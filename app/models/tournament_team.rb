class TournamentTeam < ActiveRecord::Base
  belongs_to :tournament_setup
  has_many :torunament_participants
end
