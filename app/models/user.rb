class User < ApplicationRecord
  # Adds methods to set and authenticate against a BCrypt password
  has_secure_password
  # Verify that email field is not blank and prevent duplicate email values in database
	validates :email, presence: true, uniqueness: true
  # Verify that password field cannot be blank
  validates :password, presence: true, length: { minimum: 6 }
  # To aviod case-sensitive login errors store emails in lowercase (same as gmail stores emails).
  before_save { self.email = email.downcase }
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
