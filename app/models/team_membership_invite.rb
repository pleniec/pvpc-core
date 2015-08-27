class TeamMembershipInvite < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :team

  validates :from_user, presence: true
  validates :to_user, presence: true
  validates :team, presence: true
  validate :cannot_invite_team_member

  scope :to_user_id, -> (user_id) { where(to_user_id: user_id) }

  def accept!
    TeamMembership.create!(user: to_user, team: team)
  end

  private

  def cannot_invite_team_member
    if team.users.include?(to_user)
      errors[:to_user] << 'cannot invite team member'
    end
  end
end
