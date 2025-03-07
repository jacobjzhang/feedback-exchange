require 'uri'

class Project < ApplicationRecord
  acts_as_taggable_on :categories

  belongs_to :user
  has_many :matches
  has_many :score_cards

  validates :name, :url, :description, presence: true
  validate :url_is_valid
  validates_uniqueness_of :url

  # after_save :ensure_https
  after_save :process_project

  scope :fake, -> { where(stage_type: 'fake') }
  scope :real, -> { where(stage_type: 'real') }

  def categories; end

  def url_is_valid
    errors.add(:base, "URL is invalid. Please ensure you have the https://") unless valid_url?(url)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  # def ensure_https
  #   if url.include?('http://')
  #     url = url.gsub('http://', 'https://')
  #   end
  # end

  def process_project
    begin
      ProjectProcessor.process!(self)
    rescue
      self.update_column('can_frame', false)
    end
  end
end