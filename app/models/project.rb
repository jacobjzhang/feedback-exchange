class Project < ApplicationRecord
  belongs_to :user

  def matches
    Match.where(project_one: id) + Match.where(project_two: id)
  end

  def existing_matches
    matches.select { |m| m.completed == false }
  end
end
