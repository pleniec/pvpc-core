class RenameUsersSettingsMask < ActiveRecord::Migration
  def change
    rename_column :users, :settings_mask, :flags_mask
  end
end
