class TeamMembershipProposition < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user
  belongs_to :team

  validates :user, presence: true, uniqueness: {scope: :team}
  validates :team, presence: true
  validates :type, presence: true, inclusion: {in: %w[REQUEST INVITE]}
  validate :proposition_cannot_be_made_to_or_by_team_member

  scope :user_id, -> (user_id) { where(user_id: user_id) }
  scope :team_id, ->(team_id) { where(team_id: team_id) }
  scope :type, ->(type) { where(type: type) }
  scope :requests, -> { where(type: 'REQUEST') }
  scope :invites, -> { where(type: 'INVITE') }

  def accept!
    transaction do
      TeamMembership.create!(user: user, team: team)
      destroy!
    end
  end

  private

  def proposition_cannot_be_made_to_or_by_team_member
    if team.users.include?(user)
      errors[:user] << 'is already a team member'
    end
  end
end
