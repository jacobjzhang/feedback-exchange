class Match < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :score_card, optional: true

  def complete!
    update!(status: 'complete')
  end
end
