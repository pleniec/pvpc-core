class GameGlobalizeInit < ActiveRecord::Migration
  def change
    drop_table :game_translations
    Game.create_translation_table! description: :text
  end
end
