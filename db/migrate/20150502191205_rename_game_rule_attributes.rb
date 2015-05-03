class RenameGameRuleAttributes < ActiveRecord::Migration
  def change
    rename_table :game_rule_attributes, :game_rule_entries
  end
end
