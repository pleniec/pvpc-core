require 'rails_helper'

RSpec.describe UsersController do
  before do
    @users = FactoryGirl.create_list(:user, 2)
  end

  describe 'POST #create' do
    it 'creates user' do
      post_json :create, user: {email: 'user@mail.com', nickname: 'zalu', password: 'password123'}
      expect(response.status).to eql(200)
      expect(User.exists?(response_body['id'])).to be true
    end
  end

  describe 'POST #login' do
    it 'logs in user' do
      post_json :login, email: @users[0].email, password: 'password123'
      expect(response.status).to eql(200)
      expect(response_body['access_token']).not_to be nil
    end
  end

  describe 'PATCH #update' do
    it 'updates user' do
      patch_json :update, id: @users[0].id, access_token: @users[0].session.access_token, user: {nickname: 'kalu'}
      expect(response.status).to eql(204)
      expect(@users[0].reload.nickname).to eql('kalu')
    end

    it 'cannot update other user' do
      patch_json :update, id: @users[1].id, access_token: @users[0].session.access_token, user: {nickname: 'kalu'}
      expect(response.status).to eql(403)
      expect(@users[1].reload.nickname).not_to eql('kalu')
    end
  end
end
