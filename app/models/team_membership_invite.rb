class TeamMembershipInvite < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :user, presence: true, uniqueness: {scope: :team}
  validates :team, presence: true
  validate :cannot_invite_team_member

  scope :user_id, -> (user_id) { where(user_id: user_id) }

  def accept!
    TeamMembership.create!(user: user, team: team)
  end

  private

  def cannot_invite_team_member
    if team.users.include?(user)
      errors[:user] << 'cannot invite team member'
    end
  end
end
