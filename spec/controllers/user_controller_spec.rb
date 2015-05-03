require 'rails_helper'

RSpec.describe Api::V1::UserController do
  include_examples 'without_basic_authentication',
                   create: :post, login: :post

  context 'with authentication' do
    include_context 'with_basic_authentication'

    describe 'POST create' do
      it '422 on invalid data' do
        post :create, format: :json, user: {email: '', password: ''}
        expect(response.status).to eql(422)
      end

      it 'creates user on valid data' do
        post :create, format: :json, user: {email: 'user@mail.com',
                                            password: 'password123'}
        expect(response.status).to eql(200)
        expect(User.count).to eql(1)
      end
    end

    describe 'POST login' do
      before :each do
        User.create!(email: 'user@mail.com', password: 'password123')
      end

      it '422 on invalid data' do
        post :login, format: :json, email: 'wrl', password: 'password123'
        expect(response.status).to eql(422)
      end

      it 'creates access token on valid data' do
        post :login, format: :json, email: 'user@mail.com', password: 'password123'
        response_body = JSON.parse(response.body)
        expect(response_body['access_token']).to eql(User.first.access_token)
      end
    end
  end
end
