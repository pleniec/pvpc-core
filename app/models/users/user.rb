module Users
  class User < ActiveRecord::Base
    InvalidCredentials = Class.new(StandardError)

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :user_games, class_name: 'Games::UserGame'
    has_many :games, class_name: 'Games::Game', through: :user_games
    has_many :received_invites, class_name: 'Users::FriendshipInvite', foreign_key: :to_user_id
    has_many :sent_invites, class_name: 'Users::FriendshipInvite', foreign_key: :from_user_id
    has_many :friendships, class_name: 'Users::Friendship'
    has_many :friends, through: :friendships
    has_many :founded_teams, class_name: 'Teams::Team', foreign_key: :founder_id
    has_many :user_teams, class_name: 'Teams::UserTeam'
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

    def to_builder(with_access_token = false)
      Jbuilder.new do |json|
        json.id id
        json.email email
        json.nickname nickname
        json.access_token session.access_token if with_access_token
      end
    end
  end
end
