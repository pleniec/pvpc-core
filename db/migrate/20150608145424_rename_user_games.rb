class RenameUserGames < ActiveRecord::Migration
  def change
    rename_table :user_games, :game_ownerships
  end
end
