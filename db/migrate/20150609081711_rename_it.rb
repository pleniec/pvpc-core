class RenameIt < ActiveRecord::Migration
  def change
    rename_column :friendship_invites, :user_id, :from_user_id
  end
end
