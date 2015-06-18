class AddAuthFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :settings, :integer, limit: 8, null: false, default: 0
  end
end
