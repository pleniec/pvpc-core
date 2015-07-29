class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :sex, :string
    add_column :users, :age, :integer
    add_column :users, :nationality, :string
  end
end
