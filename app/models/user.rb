class User < ActiveRecord::Base
  InvalidCredentials = Class.new(StandardError)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_games
  has_many :games, through: :user_games

  before_create :generate_access_token!

  validates :nickname, presence: true, uniqueness: true
  validates :access_token, uniqueness: true,
            if: -> (u) { u.access_token.present? }

  def self.authenticate_with_access_token(access_token)
    return nil unless access_token
    self.find_by_access_token(access_token)
  end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    raise InvalidCredentials if user.nil? || !user.valid_password?(password)
    user.generate_access_token!
    user.save!
    user
  end

  def generate_access_token!
    self.access_token = Devise.friendly_token
  end
end
