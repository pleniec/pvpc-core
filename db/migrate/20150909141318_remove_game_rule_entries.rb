class RemoveGameRuleEntries < ActiveRecord::Migration
  def change
    drop_table :game_rule_entries
  end
end
