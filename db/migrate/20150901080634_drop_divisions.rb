class DropDivisions < ActiveRecord::Migration
  def change
    drop_table :divisions
  end
end
