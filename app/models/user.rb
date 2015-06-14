class User < ActiveRecord::Base
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  validates :password, length: { minimum: 6 }

  def self.digest(string)
    BCrypt::Password.create(string)
  end

  def self.new_token
    BCrypt::Password.create(SecureRandom.urlsafe_base64)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
