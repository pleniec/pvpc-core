class AddNicknameToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, default: 'null_nick'
    change_column :users, :nickname, :string, null: false
  end
end
