class Match < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :score_card
end
