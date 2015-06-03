class AnotherRename < ActiveRecord::Migration
  def change
    rename_table :team_membership, :team_memberships
  end
end
