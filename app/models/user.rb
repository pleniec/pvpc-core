class User < ActiveRecord::Base
  InvalidCredentials = Class.new(StandardError)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :game_ownerships
  has_many :friendship_invites, foreign_key: :to_user_id
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :team_memberships
  has_many :teams, through: :team_memberships

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

  def settings
    @settings ||= UserSettings.new(self)
  end

  def strangers
    User.where.not(id: friends.pluck('users.id') + [id])
  end

  def to_builder(options = {})
    Jbuilder.new do |json|
      json.id id
      json.email email
      json.nickname nickname

      if options[:settings_mask]
        json.settings_mask settings_mask
      end

      if options[:access_token]
        json.access_token session.access_token
      end

      if options[:game_ownerships]
        json.game_ownerships game_ownerships do |game_ownership|
          json.merge! game_ownership.to_builder.attributes!
        end
      end
    end
  end
end
