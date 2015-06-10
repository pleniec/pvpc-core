ActiveAdmin.register User do
  config.batch_actions = false
  config.per_page = 10

  actions :index, :show

  filter :id
  filter :email
  filter :sign_in_count
  filter :nickname
  filter :last_sign_in_at
  filter :created_at

  index do
    id_column
    column :email
    column :sign_in_count
    column :nickname
    column :last_sign_in_at
    column :created_at
  end

  show do
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :nickname
      row :last_sign_in_at
      row :created_at
    end

    if user.friends.any?
      panel 'Friends' do
        table_for user.friends do
          column(:id) { |f| link_to f.id, admin_user_path(f) }
          column :email
          column :nickname
        end
      end
    end

    if user.game_ownerships.any?
      panel 'Games' do
        table_for user.game_ownerships.eager_load(:game) do
          column(:game) { |gs| link_to gs.game.name, admin_game_path(gs.game) }
          column :nickname
        end
      end
    end

    if user.teams.any?
      panel 'Teams' do
        table_for user.teams do
          column(:id) { |t| link_to t.id, admin_team_path(t) }
          column :name
          column :tag
        end
      end
    end

    active_admin_comments
  end 
end
