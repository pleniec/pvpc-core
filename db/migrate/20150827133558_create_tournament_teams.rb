class CreateTournamentTeams < ActiveRecord::Migration
  def change
    create_table :tournament_teams do |t|
      t.integer :tournament_setup_id, null: false
      t.timestamps null: false
    end
  end
end
