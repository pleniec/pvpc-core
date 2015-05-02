ActiveAdmin.register Game do
  permit_params :icon, :image,
                game_translations_attributes: [:id, :locale, :title,
                                               :description, :_destroy]

  form do |f|
    inputs do
      f.input :icon, as: :file, input_html: {accept: 'image/*'}
      f.input :image, as: :file, input_html: {accept: 'image/*'}
      f.has_many :game_translations, allow_destroy: true do |gtf|
        gtf.input :locale, as: :select, collection: I18n.available_locales
        gtf.input :title
        gtf.input :description
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
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
            column :title
            column :description
          end
        end
      end
    end
  end
end
