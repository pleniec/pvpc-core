class CreateTeamMembershipInvites < ActiveRecord::Migration
  def change
    create_table :team_membership_invites do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.integer :team_id, null: false
      t.timestamps null: false
    end
  end
end
