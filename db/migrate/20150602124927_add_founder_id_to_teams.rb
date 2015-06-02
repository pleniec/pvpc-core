class AddFounderIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :founder_id, :integer, null: false
  end
end
