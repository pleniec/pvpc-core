class AddKeyToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :key, :string, null: false
  end
end
