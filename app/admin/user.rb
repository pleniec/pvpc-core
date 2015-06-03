ActiveAdmin.register User do
  config.batch_actions = false

  actions :index, :show

  filter :nickname
  filter :email
  filter :sign_in_count
  filter :last_sign_in_at
  filter :created_at
  filter :updated_at

  index do
    id_column
    column :nickname
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :nickname
      row :email
      row :reset_password_sent_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end
end
