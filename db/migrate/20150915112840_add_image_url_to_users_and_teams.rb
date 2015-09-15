class AddImageUrlToUsersAndTeams < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string
    add_column :teams, :image_url, :string
  end
end
