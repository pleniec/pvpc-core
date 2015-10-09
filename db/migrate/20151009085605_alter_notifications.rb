class AlterNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :properties
    add_column :notifications, :data, :jsonb, null: false, default: {}
  end
end
