require 'rails_helper'

RSpec.describe GameOwnershipsController do
  before do
    @users = FactoryGirl.create_list(:user, 2)
    @games = FactoryGirl.create_list(:game, 5)
    @games[0..2].each do |game|
      FactoryGirl.create(:game_ownership, game: game, user: @users[0])
    end
    @games[3..4].each do |game|
      FactoryGirl.create(:game_ownership, game: game, user: @users[1])
    end
  end

  before do
    @users = FactoryGirl.create_list(:user, 2)
    @games = FactoryGirl.create_list(:game, 5)
    @games[0..2].each do |game|
      FactoryGirl.create(:game_ownership, game: game, user: @users[0])
    end
    @games[3..4].each do |game|
      FactoryGirl.create(:game_ownership, game: game, user: @users[1])
    end
  end

  describe 'GET #index' do
    it "renders user's games" do
      get_json :index, user_id: @users[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(3)
    end

    it "renders other user's games" do
      get_json :index, user_id: @users[1].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(2)
    end
  end

  describe 'POST #create' do
    it 'adds game to user' do
      post_json :create, access_token: @users[0].session.access_token,
        game_ownership: {user_id: @users[0].id, game_id: @games[3].id, nickname: 'nickname0'}
      expect(response.status).to eql(201)
      expect(@users[0].game_ownerships.count).to eql(4)
    end

    it 'cannot add game multiple times' do
      post_json :create, access_token: @users[0].session.access_token,
        game_ownership: {user_id: @users[0].id, game_id: @games[0].id, nickname: 'nickname0'}
      expect(response.status).to eql(422)
      expect(@users[0].game_ownerships.count).to eql(3)
    end

    it 'cannot add game to other user' do
      post_json :create, access_token: @users[0].session.access_token,
        game_ownership: {user_id: @users[1].id, game_id: @games[0].id, nickname: 'nickname0'}
      expect(response.status).to eql(403)
      expect(@users[1].game_ownerships.count).to eql(2)
    end
  end

  describe 'PATCH #update' do
    it "updates user's nickname" do
      patch_json :update, user_id: @users[0].id, id: @users[0].game_ownerships[0].id,
        access_token: @users[0].session.access_token, game_ownership: {nickname: 'nyk'}
      expect(response.status).to eql(200)
      expect(@users[0].game_ownerships[0].reload.nickname).to eql('nyk')
    end

    it "cannot update other user's nickname" do
      patch_json :update, user_id: @users[1].id, id: @users[1].game_ownerships[0].id,
        access_token: @users[0].session.access_token, game_ownership: {nickname: 'nyk'}
      expect(response.status).to eql(403)
      expect(@users[1].game_ownerships[0].reload.nickname).not_to eql('nyk')
    end
  end

  describe 'DELETE #destroy' do
    it "removes game from user's account" do
      delete_json :destroy, user_id: @users[0].id, id: @users[0].game_ownerships[0].id,
        access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(@users[0].game_ownerships.count).to eql(2)
    end

    it "cannot remove game from other user's account" do
      delete_json :destroy, user_id: @users[1].id, id: @users[1].game_ownerships[0].id,
        access_token: @users[0].session.access_token
      expect(response.status).to eql(403)
      expect(@users[1].game_ownerships.count).to eql(2)
    end
  end
end
