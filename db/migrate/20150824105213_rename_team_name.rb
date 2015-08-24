class RenameTeamName < ActiveRecord::Migration
  def change
    rename_column :teams, :name, :nickname
  end
end
