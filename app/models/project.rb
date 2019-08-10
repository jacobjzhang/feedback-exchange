class Project < ApplicationRecord
  acts_as_taggable_on :categories

  belongs_to :user
  has_many :matches

  validates_uniqueness_of :url

  def categories; end
end
