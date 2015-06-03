class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :team_id, null: false
      t.integer :game_id, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
