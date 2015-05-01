class AddIconToGames < ActiveRecord::Migration
  def change
    add_column :games, :icon, :string
  end
end
