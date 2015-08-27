class CreateTournamentSetups < ActiveRecord::Migration
  def change
    create_table :tournament_setups do |t|
      t.integer :game_id, null: false
      t.integer :minimal_number_of_teams_to_start, null: false
      t.integer :maximal_number_of_teams, null: false
      t.datetime :sign_up_start_at, null: false
      t.datetime :sign_up_end_at, null: false
      t.integer :number_of_participants_per_team, null: false
      t.timestamps null: false
    end
  end
end
