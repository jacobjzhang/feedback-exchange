class ScoreCard < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :match

  def complete_match!
    match = Match.find_by(user: user, project: project)
    update(match: match)
    match.complete!
  end
end
