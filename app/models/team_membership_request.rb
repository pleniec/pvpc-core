class TeamMembershipRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :user, presence: true, uniqueness: {scope: :team}
  validates :team, presence: true
  validate :team_member_cannot_request_team_membership

  scope :team_id, ->(team_id) { where(team_id: team_id) }

  def accept!
    TeamMembership.create!(user: user, team: team)
  end

  private

  def team_member_cannot_request_team_membership
    if team.users.include?(user)
      errors[:user] << 'team member cannot request team membership'
    end
  end
end
