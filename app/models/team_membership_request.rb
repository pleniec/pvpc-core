class TeamMembershipRequest < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User'
  belongs_to :team

  validates :from_user, presence: true, uniqueness: {scope: :team}
  validates :team, presence: true
  validate :team_member_cannot_request_team_membership

  scope :team_id, ->(team_id) { where(team_id: team_id) }

  def accept!
    TeamMembership.create!(user: from_user, team: team)
  end

  private

  def team_member_cannot_request_team_membership
    if team.users.include?(from_user)
      errors[:to_user] << 'team member cannot request team membership'
    end
  end
end
