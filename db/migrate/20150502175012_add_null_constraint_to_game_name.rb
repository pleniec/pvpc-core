class AddNullConstraintToGameName < ActiveRecord::Migration
  def change
    change_column :games, :name, :string, null: false
  end
end
