class RemoveTeamMembershipRequestsAndInvites < ActiveRecord::Migration
  def change
    drop_table :team_membership_invites
    drop_table :team_membership_requests
  end
end
