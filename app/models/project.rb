require 'uri'

class Project < ApplicationRecord
  acts_as_taggable_on :categories

  belongs_to :user
  has_many :matches
  has_many :score_cards

  validates :name, :url, :description, presence: true
  validate :url_is_valid
  validates_uniqueness_of :url

  def categories; end

  def url_is_valid
    errors.add(:base, "URL is invalid.") unless valid_url?(url)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end