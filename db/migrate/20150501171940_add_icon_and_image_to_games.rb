class AddIconAndImageToGames < ActiveRecord::Migration
  def change
    add_column :games, :icon, :string, null: false
    add_column :games, :image, :string, null: false
  end
end
