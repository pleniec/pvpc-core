class CreateTournamentParticipants < ActiveRecord::Migration
  def change
    create_table :tournament_participants do |t|
      t.integer :tournament_team_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
