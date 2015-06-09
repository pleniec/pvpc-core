class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :team_id, -> (id) { where(team_id: id) }
  scope :user_id, -> (id) { where(user_id: id) }

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.user user.to_builder.attributes!
      json.team team.to_builder.attributes!
    end
  end
end
