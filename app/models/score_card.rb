class ScoreCard < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :match

  validates :user, :project, :idea_rating, :design_rating, :experience_rating, presence: true
  validates :project, uniqueness: { scope: :user }
  validate :written_text_must_be_140

  acts_as_readable on: :created_at

  def complete_match!
    match = Match.find_by(user: user, project: project)
    update(match: match)
    match.complete!
  end

  def written_text_must_be_140
    unless idea.length + design.length + experience.length + monetization.length + suggestions.length > 140
      errors.add(:base, "Please write at least 140 characters of feedback. All text fields are considered.")
    end
  end
end
