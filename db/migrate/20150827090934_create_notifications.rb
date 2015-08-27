class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :type, null: false
      t.boolean :seen, null: false, default: false
      t.hstore :properties
      t.timestamps null: false
    end
  end
end
