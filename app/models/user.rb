class User < ApplicationRecord
  acts_as_taggable_on :interests
  acts_as_reader
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :matches

  after_commit :find_first_match, only: [:create, :update]

  scope :real, -> { where(stage_type: 'real') }

  def interests; end

  def find_first_match
    MatchCreator.create_match(self)
  end
end
