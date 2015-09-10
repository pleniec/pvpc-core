class RenameUserColumnInTeamMembershipRequests < ActiveRecord::Migration
  def change
    rename_column :team_membership_requests, :from_user_id, :user_id
  end
end
