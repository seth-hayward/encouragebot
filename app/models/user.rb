require 'user_type'

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_many :goals, dependent: :destroy

  before_save { self.email.downcase! }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # active_enum gem
  enumerate :user_type, :with => UserType

  private

  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
