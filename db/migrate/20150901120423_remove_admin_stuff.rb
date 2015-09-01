class RemoveAdminStuff < ActiveRecord::Migration
  def change
    drop_table :active_admin_comments
    drop_table :admins
  end
end
