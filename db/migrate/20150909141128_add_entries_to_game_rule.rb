class AddEntriesToGameRule < ActiveRecord::Migration
  def change
    add_column :game_rules, :entries, :hstore, null: false, default: ''
  end
end
