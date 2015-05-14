require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  context 'unauthenticated' do
    include_context 'http_authenticated'

    describe 'POST #create' do
      it 'creates user' do
        post :create, format: :json, user: {email: 'user@mail.com', nickname: 'zalu', password: 'password123'}
        expect(response.status).to eql(200)
        expect(User.count).to eql(1)
      end

      it "doesn't create user on invalid data" do
        post :create, format: :json, user: {sraken: 'hehe'}
        expect(response.status).to eql(422)
        expect(User.count).to eql(0)
      end
    end
  end

  context 'authenticated' do
    include_context 'authenticated'
  end

=begin
  context 'authenticated (http)' do

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
=end
end
