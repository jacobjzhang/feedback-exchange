class Project < ApplicationRecord
  acts_as_taggable_on :categories

  belongs_to :user
  has_many :matches
  has_many :score_cards

  validates_uniqueness_of :url

  def categories; end
end
