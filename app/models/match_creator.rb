class MatchCreator < ApplicationRecord
  def self.create_matches
    User.includes(:taggings).where(status: 'idle').each do |user|
      next_user = false
      interest_list = user.interest_list
      interest_list.each do |interest|
        made_match = find_and_match_project(user, interest)
        break if made_match
      end
    end
  end

  def self.find_and_match_project(user, interest)
    if memo[interest]
      potential_projects = memo[interest]
    else
      potential_projects = Project.tagged_with(interest)
      memo[interest] = potential_projects
    end

    projects_by_others = potential_projects.where.not(user: user)

    projects_by_others.each do |project|
      match = Match.find_by(project: project, user: user)

      next if match.count > 0

      byebug

      if match.save
        return true
      end
    end

    return false
  end

  def self.memo
    @hash ||= {}
  end
end
