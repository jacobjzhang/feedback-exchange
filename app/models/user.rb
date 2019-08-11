class User < ApplicationRecord
  acts_as_taggable_on :interests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :projects
  has_many :matches

  def interests; end
end
