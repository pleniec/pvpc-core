require 'rails_helper'

RSpec.describe NotificationsController do
  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:notification, user: user) },
                   permitted_params: ->(model) { {user_id: model.user_id, created_at: model.created_at,
                                                  checked: model.checked} },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:notification) },
                   forbidden_params: ->(model) { {user_id: model.user_id, created_at: model.created_at,
                                                  checked: model.checked} }

  include_examples :update, params: {'checked' => true},
                   create_permitted_model: ->(user) { FactoryGirl.create(:notification, user: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:notification) }

  describe '#update' do
    context 'when user tries to uncheck notification' do
      it 'renders validation error' do
        user = FactoryGirl.create(:user)
        notification = FactoryGirl.create(:notification, user: user, checked: true)

        update id: notification.id, access_token: user.session.access_token, checked: false

        expect(response.status).to eql 422
      end
    end
  end
end
