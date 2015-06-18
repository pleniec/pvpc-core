require 'rails_helper'

RSpec.describe UsersController do
  describe 'POST #create' do
    it 'creates user' do
      post_json :create, user: {email: 'user@mail.com', nickname: 'zalu', password: 'password123'}
      expect(response.status).to eql(200)
      expect(User.exists?(response_body['id'])).to be true
    end
  end

  describe 'POST #login' do
    it 'logs in user' do
      @user = FactoryGirl.create(:user)
      post_json :login, email: @user.email, password: 'password123'
      expect(response.status).to eql(200)
      expect(response_body['access_token']).not_to be nil
    end
  end

  describe 'GET #show' do
    it 'renders single user' do
      @user = FactoryGirl.create(:user_with_game_ownerships)
      get_json :show, id: @user.id
      expect(response.status).to eql(200)
      expect(response_body['id']).to eql(@user.id)
    end
  end

  describe 'PATCH #update' do
    it 'updates user' do
      @users = FactoryGirl.create_list(:user, 2)
      patch_json :update, id: @users[0].id, access_token: @users[0].session.access_token, user: {nickname: 'kalu'}
      expect(response.status).to eql(204)
      expect(@users[0].reload.nickname).to eql('kalu')
    end

    it 'cannot update other user' do
      @users = FactoryGirl.create_list(:user, 2)
      patch_json :update, id: @users[1].id, access_token: @users[0].session.access_token, user: {nickname: 'kalu'}
      expect(response.status).to eql(403)
      expect(@users[1].reload.nickname).not_to eql('kalu')
    end
  end

  describe 'GET #strangers' do
    it 'is' do
      @users = FactoryGirl.create_list(:user, 3)
      FriendshipInvite.create(from_user: @users[0], to_user: @users[1]).accept!
      get_json :strangers, id: @users[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.first['id']).to eql(@users[2].id)
    end
  end
end
