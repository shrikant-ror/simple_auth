class User < ApplicationRecord
  # Adds methods to set and authenticate against a BCrypt password
  has_secure_password
  # Verify that email field is not blank and prevent duplicate email values in database
	validates :email, presence: true, uniqueness: true
end
