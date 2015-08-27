class TournamentSetup < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :minimal_number_of_teams_to_start, presence: true, numericality: {greater_than: 0}
  validates :maximal_number_of_teams, presence: true, inclusion: {in: [8, 16, 32, 64, 128, 256]}
  validates :sign_up_start_at, presence: true
  validates :sign_up_end_at, presence: true
  validates :number_of_participants_per_team, presence: true, numericality: {greater_than: 0}
end
