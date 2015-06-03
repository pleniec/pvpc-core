class User < ActiveRecord::Base
  InvalidCredentials = Class.new(StandardError)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_games
  has_many :games, through: :user_games
  has_many :received_invites, class_name: 'FriendshipInvite', foreign_key: :to_user_id
  has_many :sent_invites, class_name: 'FriendshipInvite', foreign_key: :from_user_id
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :user_teams
  has_many :teams, through: :user_teams

  after_create { session.create }

  validates :nickname, presence: true, uniqueness: true

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    raise InvalidCredentials if user.nil? || !user.valid_password?(password)
    user.session.create
    user
  end

  def session
    @session ||= Session.new(user: self)
  end

  def to_hash_without_access_token
    {id: id, email: email, nickname: nickname}
  end

  def to_hash_with_access_token
    to_hash_without_access_token.merge(access_token: session.access_token)
  end
end
