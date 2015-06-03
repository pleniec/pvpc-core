class RenameTab < ActiveRecord::Migration
  def change
    rename_table :user_teams, :team_membership
  end
end
