class MatchCreator < ApplicationRecord
  def self.create_matches
    User.includes(:taggings).where(status: 'idle').each do |user|
      create_match(user)

      if user.matches.where(status: 'pending').count > 20
        # we don't want the callback to kick this process off again
        user.update_column('status', 'reviewing')
      end
    end
  end

  def self.create_match(user)
    interest_list = user.interest_list
    # find_and_match_projects returns true if a match was made
    find_and_match_projects(user, interest_list)
    # move onto the next user if there's a match
  end

  def self.fan_out_project!(user)
    user.projects.each do |project|
      potential_users = User.tagged_with(project.category_list, any: true)
      potential_users.each do |user|
        match = Match.find_by(project: project, user: user)
        next if match

        match = Match.new(project: project, user: user)
        if match.save
          return true
        end
      end
    end
  end

  def self.find_and_match_projects(user, interest_list)
    # more efficient project lookups
    if memo[interest_list]
      potential_projects = memo[interest_list]
    else
      potential_projects = Project.tagged_with(interest_list, any: true)
      memo[interest_list] = potential_projects
    end

    projects_not_reviewed = Project.where("id NOT IN 
      ( 
             SELECT matches.project_id 
             FROM   projects
             JOIN   matches
             ON     matches.project_id = projects.id 
             WHERE  matches.user_id = #{user.id})
      AND 
      projects.user_id != #{user.id}").limit(5)

    projects_not_reviewed.each do |project|
      match = Match.find_by(project: project, user: user)

      next if match

      match = Match.create!(project: project, user: user)
    end
  end

  def self.memo
    @hash ||= {}
  end
end
