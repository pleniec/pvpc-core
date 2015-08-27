class RenameNotificationColumn < ActiveRecord::Migration
  def change
    rename_column :notifications, :seen, :checked
  end
end
