class CreateTranslationTableForGames < ActiveRecord::Migration
  def up
    Game.create_translation_table! title: :string, description: :string
  end
end
