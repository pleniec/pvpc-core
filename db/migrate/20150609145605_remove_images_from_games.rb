class RemoveImagesFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :icon
    remove_column :games, :image
  end
end
