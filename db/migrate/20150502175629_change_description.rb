class ChangeDescription < ActiveRecord::Migration
  def change
    change_column :game_translations, :description, :text, null: false
  end
end
