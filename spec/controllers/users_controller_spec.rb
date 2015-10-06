require 'rails_helper'

RSpec.describe UsersController do
  it 'lols' do
    user = FactoryGirl.create(:user_with_game_ownerships)

    show id: user.id, format: :json

    raise Exception, response_body
  end
=begin
  include_examples :authentication, restricted: {update: :patch}, free: {create: :post, show: :get, index: :get}

  include_examples :create,
                   permitted_params: ->(user) { FactoryGirl.attributes_for(:user) }

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:user) },
                   permitted_params: ->(model) { {nickname: model.nickname,
                                                  strangers_to_user_id: FactoryGirl.create(:user).id} }

  include_examples :show,
                   create_permitted_model: ->(user) { FactoryGirl.create(:user) }

  include_examples :update, params: {'nickname' => 'sracz'},
                   create_permitted_model: ->(user) { user },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:user) }

  describe 'POST #login' do
    context 'with correct credentials' do
      it 'logs in user' do
        @user = FactoryGirl.create(:user)
        post_json :login, email: @user.email, password: 'password123'
        expect(response.status).to eql(200)
        expect(response_body['access_token']).not_to be nil
      end
    end

    context 'with incorrect credentials' do
      it 'renders errors' do
        @user = FactoryGirl.create(:user)
        post_json :login, email: @user.email, password: 'password???'
        expect(response.status).to eql(422)
        expect(response_body['access_token']).to be nil
      end
    end
  end
=end
end
