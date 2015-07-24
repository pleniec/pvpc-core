class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :team_id, -> (id) { where(team_id: id) }
  scope :user_id, -> (id) { where(user_id: id) }
end
