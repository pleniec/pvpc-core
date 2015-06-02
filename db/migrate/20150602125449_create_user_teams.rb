class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :user_teams do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.boolean :captain, null: false, default: false
      t.timestamps null: false
    end
  end
end
