class RenameUserSettings < ActiveRecord::Migration
  def change
    rename_column :users, :settings, :settings_mask
  end
end
