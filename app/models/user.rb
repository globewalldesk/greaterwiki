class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i   # used to check that input email is hip to the groove
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 8 }
  validates :password, format: { with: /[a-z]/ }
  validates :password, format: { with: /[A-Z]/ }
  validates :password, format: { with: /\d/ }
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token (for logging the user in securely, in persistent sessions).
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    digest_of_token = User.digest(remember_token)
    update_attribute(:remember_digest, digest_of_token)
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Forgets a user, i.e., deletes his digest so he can't use his token anymore.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end