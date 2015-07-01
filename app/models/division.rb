class Division < ActiveRecord::Base
  belongs_to :team
  belongs_to :game

  scope :team_id, ->(team_id) { where(team_id: team_id) }
  scope :game_id, ->(game_id) { where(game_id: game_id) }
end
