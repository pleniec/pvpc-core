class User < ActiveRecord::Base
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

  scope :nickname, ->(nickname) { where(User.arel_table[:nickname].matches("#{nickname}%")) }
  scope :strangers_to_user_id, ->(user_id) { where.not(id: Friendship.where(user_id: user_id).pluck(:friend_id) + [user_id]) }

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    return nil if user.nil? || !user.valid_password?(password)
    user.session.create
    user
  end

  def session
    @session ||= Session.new(user: self)
  end

  def settings
    @settings ||= UserSettings.new(self)
  end

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id id
      json.email email
      json.nickname nickname

      if action == :login || action == :create
        json.settings_mask settings_mask
        json.access_token session.access_token
      end

      if action == :login
        json.game_ownerships game_ownerships do |game_ownership|
          json.merge! game_ownership.to_builder(controller, action).attributes!
        end
      end
    end
  end
end
