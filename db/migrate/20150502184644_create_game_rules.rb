class CreateGameRules < ActiveRecord::Migration
  def change
    create_table :game_rules do |t|
      t.integer :game_id, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
