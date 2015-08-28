class TournamentParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament_team
end
