class CreateTeamMembershipPropositions < ActiveRecord::Migration
  def change
    create_table :team_membership_propositions do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.string :type, null: false
      t.timestamps null: false
    end
  end
end
