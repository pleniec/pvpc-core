class RemoveFromUserIdFromTeamMembershipInvites < ActiveRecord::Migration
  def change
    remove_column :team_membership_invites, :from_user_id
  end
end
