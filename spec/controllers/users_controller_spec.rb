require 'rails_helper'

RSpec.describe UsersController do
  describe 'POST #create' do
    it 'creates user' do
      create email: 'user@mail.com', nickname: 'zalu', password: 'password123'
      expect(response.status).to eql(201)
      expect(User.exists?(response_body['id'])).to be true
    end

    it 'renders errors on invalid values' do
      create email: 'yyywhat?', nickname: 'zalu', password: 'password123'
      expect(response.status).to eql(422)
      expect(User.count).to eql(0)
    end 
  end

  describe 'POST #login' do
    it 'logs in user' do
      @user = FactoryGirl.create(:user)
      post_json :login, email: @user.email, password: 'password123'
      expect(response.status).to eql(200)
      expect(response_body['access_token']).not_to be nil
    end

    it 'renders errors on invalid credentials' do
      @user = FactoryGirl.create(:user)
      post_json :login, email: @user.email, password: 'password???'
      expect(response.status).to eql(422)
      expect(response_body['access_token']).to be nil
    end
  end

  describe 'GET #show' do
    it 'renders single user' do
      @user = FactoryGirl.create(:user_with_game_ownerships)
      show id: @user.id
      expect(response.status).to eql(200)
      expect(response_body['id']).to eql(@user.id)
    end
  end

  describe '#index' do
    before do
      @users = FactoryGirl.create_list(:user, 5)
    end

    context 'without access_token parameter' do
      it 'renders all users' do
        index
        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql(5)
      end

      it 'renders users with nickname starting with string' do
        @users[3..4].each do |user|
          user.nickname = 'hihi' + rand(1000).to_s
          user.save!
        end
        index nickname: 'hi'
        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql(2)
      end

      it 'renders strangers to provided user id' do
        FriendshipInvite.create!(from_user: @users[0], to_user: @users[1]).accept!
        index strangers_to_user_id: @users[0].id
        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql(3)
      end

      it "doesn't render users with relation_to_current_user" do
        index

        response_body['models'].each do |hash|
          expect(hash['relation_to_current_user']).to be_nil
        end
      end
    end

    context 'with access_token parameter' do
      it 'renders users with relation_to_current_user' do
        index access_token: @users[0].session.access_token

        response_body['models'].each do |hash|
          expect(hash['relation_to_current_user']).not_to be_nil
        end
      end
    end
  end

  describe 'PATCH #update' do
    it 'updates user' do
      @user = FactoryGirl.create(:user)
      update id: @user.id, access_token: @user.session.access_token, nickname: 'kalu',
        flags: {block_messages_from_strangers: true}
      expect(response.status).to eql(200)
      @user.reload
      expect(@user.nickname).to eql('kalu')
      expect(@user.flags.block_messages_from_strangers).to be true
    end

    it 'renders errors on invalid values' do
      @user = FactoryGirl.create(:user)
      update id: @user.id, access_token: @user.session.access_token, nickname: ''
      expect(response.status).to eql(422)
    end

    it 'cannot update other user' do
      @users = FactoryGirl.create_list(:user, 2)
      update id: @users[1].id, access_token: @users[0].session.access_token, nickname: 'kalu'
      expect(response.status).to eql(403)
      expect(@users[1].reload.nickname).not_to eql('kalu')
    end
  end
end
