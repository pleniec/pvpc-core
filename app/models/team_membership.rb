class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  def to_hash_with_user
    {id: id, user: user.to_hash_without_access_token}
  end

  def to_hash_with_team
    {id: id, team: team.to_simple_hash}
  end
end
