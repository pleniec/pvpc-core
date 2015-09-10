class RenameUserColumnInTeamMembershipInvites < ActiveRecord::Migration
  def change
    rename_column :team_membership_invites, :to_user_id, :user_id
  end
end
