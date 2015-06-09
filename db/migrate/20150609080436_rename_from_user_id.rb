class RenameFromUserId < ActiveRecord::Migration
  def change
    rename_column :friendship_invites, :from_user_id, :user_id
  end
end
