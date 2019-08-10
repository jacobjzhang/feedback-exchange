class MatchCreator < ApplicationRecord
  def self.create_match(project_id)
    if empty_project_two_match
      empty_project_two_match(project_id).update!(
        project_two: project_id,
        creator_second: Project.find(project_id).user.id
      )
      return empty_project_two_match
    else
      return Match.create!(
        project_one: project_id,
        creator_first: Project.find(project_id).user.id
      )
    end
  end

  def self.empty_project_two_match(project_id)
    @empty_project_two_match ||= Match.where.not(project_one: project_id).where(project_two: nil).last
  end
end
