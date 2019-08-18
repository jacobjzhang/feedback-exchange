class ScoreCard < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project
  has_one :match

  validates :project, :idea_rating, :design_rating, :experience_rating, presence: true
  validates :project, uniqueness: { scope: :user }, if: :user
  validate :written_text_must_be_40

  acts_as_readable on: :created_at
  acts_as_votable

  def complete_match!
    if user
      match = Match.find_by(user: user, project: project)
      update(match: match)
      match.complete!
    end
  end

  def written_text_must_be_40
    unless idea.length + design.length + experience.length + monetization.length + suggestions.length > 40
      errors.add(:base, "Please write at least 40 characters of feedback combined. All text fields are considered.")
    end
  end
end
