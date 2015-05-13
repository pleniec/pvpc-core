require 'rails_helper'

RSpec.describe Api::V1::UserController do
  context 'authenticated (http)' do
    include_context 'http_authenticated'

    describe 'POST create' do
      it '422 on invalid data' do
        post :create, format: :json, user: {bad_attribute: '20c35u'}
        expect(response.status).to eql(422)
      end

      it 'creates user on valid data' do
        post :create, format: :json, user: FactoryGirl.attributes_for(:user)
        expect(response.status).to eql(200)
        expect(User.any?).to be true
      end
    end

    describe 'POST login' do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it '422 on invalid data' do
        post :login, format: :json, email: 'wrl', password: 'password123'
        expect(response.status).to eql(422)
      end

      it 'creates access token on valid data' do
        post :login, format: :json, email: @user.email, password: 'password123'
        response_body = JSON.parse(response.body)
        expect(response_body['access_token']).to eql(User.first.access_token)
      end
    end
  end
end
