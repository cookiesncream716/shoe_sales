class User < ActiveRecord::Base
	has_many :shoes
	has_many :purchases
	has_many :sales
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
  validates :password, length: {minimum: 8}, allow_nil: true
end
