class RenameTeamName < ActiveRecord::Migration
  def change
    rename_column :teams, :nickname, :name
  end
end
