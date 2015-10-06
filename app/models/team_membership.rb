class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :team_id, -> (id) { where(team_id: id) }
  scope :user_id, -> (id) { where(user_id: id) }

  before_destroy do
    if user == team.try(:founder)
      errors[:user] << "can't remove founder from team"
      false
    end
  end
end
