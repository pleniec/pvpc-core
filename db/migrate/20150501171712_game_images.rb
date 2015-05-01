class GameImages < ActiveRecord::Migration
  def change
    remove_column :games, :icon
  end
end
