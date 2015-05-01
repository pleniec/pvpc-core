class GamesTranslations < ActiveRecord::Migration
  def change
    drop_table :game_translations
    remove_column :games, :title
    remove_column :games, :description

    create_table :game_translations do |t|
      t.integer :game_id, null: false
      t.string :locale, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end
end
