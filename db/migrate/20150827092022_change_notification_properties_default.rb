class ChangeNotificationPropertiesDefault < ActiveRecord::Migration
  def change
    change_column :notifications, :properties, :hstore, default: '', null: false
  end
end
