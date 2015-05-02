class RemoveTitleFromGameTranslation < ActiveRecord::Migration
  def change
    remove_column :game_translations, :title
  end
end
