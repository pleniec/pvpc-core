ActiveAdmin.register Game do
  permit_params :name, :icon, :image,
                game_translations_attributes: [:id, :locale,
                                               :description, :_destroy],
                rules_attributes: [:id, :name, :_destroy,
                  entries_attributes: [:id, :key, :value, :_destroy]]

  filter :name
  filter :created_at
  filter :updated_at

  form do |f|
    inputs do
      f.input :name
      f.input :icon, as: :file, input_html: {accept: 'image/*'}
      f.input :image, as: :file, input_html: {accept: 'image/*'}
      f.has_many :game_translations, allow_destroy: true do |gtf|
        gtf.input :locale, as: :select, collection: I18n.available_locales
        gtf.input :description
      end
      f.has_many :rules, allow_destroy: true do |grf|
        grf.input :name
        grf.has_many :entries, allow_destroy: true do |graf|
          graf.input :key
          graf.input :value
        end
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :icon do |game|
      image_tag game.icon
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :icon do
        image_tag game.icon
      end
      row :image do
        image_tag game.image
      end
      row :created_at
      row :updated_at
      if game.game_translations.any?
        panel 'Translations' do
          table_for game.game_translations do
            column :id
            column :locale
            column :description
          end
        end
      end
      if game.rules.any?
        panel 'Rules' do
          table_for game.rules do
            column :id
            column :name
            column :entries do |rule|
              rule.entries.map { |e| "#{e.key}: #{e.value}" }.join(', ')
            end
          end
        end
      end
    end
  end
end
