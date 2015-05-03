class RemoveDefaultNicknameFromUser < ActiveRecord::Migration
  def change
    change_column_default :users, :nickname, nil
  end
end
