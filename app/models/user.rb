class User < ActiveRecord::Base
  include Flags
  
  FLAGS = [:block_messages_from_strangers, :block_messages_from_foreign_teams, :play_message_sound,
           :open_new_message, :notify_on_new_friendship_invite, :notify_on_new_message_on_my_profile,
           :notify_on_new_tournament_in_observed_games, :notify_3_days_before_upcoming_match,
           :notify_1_days_before_upcoming_match, :notify_12_hours_before_upcoming_match,
           :notify_6_hours_before_upcoming_match, :notify_3_hours_before_upcoming_match,
           :notify_1_hours_before_upcoming_match, :notify_30_minutes_before_upcoming_match,
           :notify_15_minutes_before_upcoming_match, :notify_on_match_cancellation, :notify_on_match_shift_request,
           :notify_on_new_message_attached_to_match, :notify_on_new_challenge, :notify_on_challenge_changes_request,
           :notify_on_challenge_cancellation, :notify_on_new_message_attached_to_challenge, :notify_on_league_start,
           :notify_on_notify_on_upcoming_league_match, :notify_3_days_before_upcoming_tournament,
           :notify_1_days_before_upcoming_tournament, :notify_12_hours_before_upcoming_tournament,
           :notify_6_hours_before_upcoming_tournament, :notify_3_hours_before_upcoming_tournament,
           :notify_1_hours_before_upcoming_tournament, :notify_30_minutes_before_upcoming_tournament,
           :notify_15_minutes_before_upcoming_tournament, :notify_on_upcoming_tournament_match,
           :notify_on_new_team_member, :notify_on_team_member_leave, :notify_on_new_division, :notify_on_division_removal,
           :notify_on_team_promotions_and_degradations, :notify_on_new_message_attached_to_team_profile]
  flags *FLAGS

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :game_ownerships
  has_many :received_friendship_invites, class_name: 'FriendshipInvite', foreign_key: :to_user_id
  has_many :sent_friendship_invites, class_name: 'FriendshipInvite', foreign_key: :from_user_id
  has_many :team_membership_propositions
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :notifications
  has_many :comments, as: :commentable

  after_create { session.create }

  validates :nickname, presence: true, uniqueness: true, length: {in: 4..30}
  validates :sex, inclusion: {in: %w[M F]}, allow_blank: true
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :nationality, inclusion: {in: Country.all.map { |c| c[1] }}, allow_blank: true

  scope :nickname, ->(nickname) { where(User.arel_table[:nickname].matches("#{nickname}%")) }
  scope :strangers_to_user_id, ->(user_id) { where.not(id: Friendship.where(user_id: user_id).pluck(:friend_id) + [user_id]) }

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    return nil if user.nil? || !user.valid_password?(password)
    user.session.create
    user
  end

  def relation_to_user(user)
    if friends.include?(user)
      'FRIEND'
    elsif received_friendship_invites.map(&:from_user).include?(user)
      'RECEIVED_FRIENDSHIP_INVITE'
    elsif sent_friendship_invites.map(&:to_user).include?(user)
      'SENT_FRIENDSHIP_INVITE'
    elsif user == self
      'SELF'
    else
      'STRANGER'
    end
  end

  def relation_to_team(team)
    if team.founder == self
      'FOUNDER'
    elsif team.captains.include?(self)
      'CAPTAIN'
    elsif team.users.include?(self)
      'MEMBER'
    elsif  team_membership_propositions.invites.map(&:team).include?(team)
      'RECEIVED_TEAM_MEMBERSHIP_INVITE'
    elsif team_membership_propositions.requests.map(&:team).include?(team)
      'REQUESTED_TEAM_MEMBERSHIP'
    else
      'STRANGER'
    end
  end

  def session
    @session ||= Session.new(user: self)
  end
end
