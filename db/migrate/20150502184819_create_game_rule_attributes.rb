class CreateGameRuleAttributes < ActiveRecord::Migration
  def change
    create_table :game_rule_attributes do |t|
      t.integer :game_rule_id, null: false
      t.string :key, null: false
      t.string :value, null: false
      t.timestamps null: false
    end
  end
end
