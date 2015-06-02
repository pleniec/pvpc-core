require 'rails_helper'

RSpec.describe API::V1::UsersController do
  include_context 'flush_redis'
  
  context 'unauthenticated' do
    include_context 'http_authenticated', 'pvpc', 'pefalpe987'

    describe 'POST #create' do
      it 'creates user' do
        post :create, format: :json, user: {email: 'user@mail.com', nickname: 'zalu', password: 'password123'}
        expect(response.status).to eql(200)
        expect(Users::User.count).to eql(1)
      end

      it "doesn't create user on invalid data" do
        post :create, format: :json, user: {sraken: 'hehe'}
        expect(response.status).to eql(422)
        expect(Users::User.count).to eql(0)
      end
    end

    describe 'POST #login' do
      before do
        @user = FactoryGirl.create(:user)
      end

      it 'authenticates user' do
        post :login, format: :json, email: @user.email, password: 'password123'
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)['access_token']).not_to be nil
      end

      it "doesn't authenticate user on invalid credentials" do
        post :login, format: :json, email: @user.email, password: 'password123456'
        expect(response.status).to eql(422)
      end
    end
  end

  context 'authenticated' do
    include_context 'authenticated'

    describe 'GET #index' do
      it 'renders users' do
        get :index, format: :json, access_token: @users[0].session.access_token
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body).all? { |u| u['access_token'].nil? })
      end
    end

    describe 'PATCH #update' do
      it 'updates user' do
        patch :update, id: @users[0].id, access_token: @users[0].session.access_token, format: :json,
          user: {email: 'troll@zal.pl'}
        expect(response.status).to eql(200)
        expect(@users[0].reload.email).to eql('troll@zal.pl')
      end

      it "doesn't update other user" do
        patch :update, id: @users[1].id, access_token: @users[0].session.access_token, format: :json,
          user: {email: 'troll@zal.pl'}
        expect(response.status).to eql(403)
      end
    end
  end
end
