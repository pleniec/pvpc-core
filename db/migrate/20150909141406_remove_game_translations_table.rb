class RemoveGameTranslationsTable < ActiveRecord::Migration
  def change
    drop_table :game_translations
  end
end
