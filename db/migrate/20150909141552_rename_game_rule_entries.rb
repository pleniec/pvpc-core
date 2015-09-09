class RenameGameRuleEntries < ActiveRecord::Migration
  def change
    rename_column :game_rules, :entries, :properties
  end
end
