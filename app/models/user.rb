class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_USERNAMES = /\A\w+\z/
  validates :username, presence: true, length: { maximum: 30 },
                       format: { with: VALID_USERNAMES },
                       uniqueness: true

  VALID_EMAIL_ADDRESSES = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_ADDRESSES },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Return the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
