class User < ActiveRecord::Base
	attr_accessor :remember_token
	before_save {
		self.email = email.downcase
		self.username = username.downcase
	}
	before_destroy {
		cars = self.cars.delete_all
	}
  validates :username, presence: true, length: { maximum: 20 },
	uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, if: :password
  has_many :cars, :dependent => :destroy
	has_many :favorites, :dependent => :destroy

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	def authenticated?(remember_token)
		return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
