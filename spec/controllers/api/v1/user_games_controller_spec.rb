require 'rails_helper'

RSpec.describe API::V1::UserGamesController do
  include_context 'authenticated'
  include_context 'flush_redis'

  before do
    @games = FactoryGirl.create_list(:game, 4).to_a
    @user_games = @games[0..1].map do |game|
      FactoryGirl.create(:user_game, user: @users[0], game: game)
    end
  end

  describe 'GET #index' do
    it "renders user's games" do
      get :index, user_id: @users[0].id, access_token: @users[0].session.access_token, format: :json
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).size).to eql(2)
    end
  end

  describe 'POST #create' do
    it 'adds game to user' do
      post :create, user_id: @users[0].id, access_token: @users[0].session.access_token, format: :json,
        user_game: {nickname: 'nickname', game_id: @games[2].id}
      expect(@users[0].games.count).to eql(3)
    end

    it 'does not add duplicates' do
      post :create, user_id: @users[0].id, access_token: @users[0].session.access_token, format: :json,
        user_game: {nickname: 'nickname', game_id: @games[0].id}
      expect(response.status).to eql(422)
    end

    it 'adds game to other user' do
      post :create, user_id: @users[1].id, access_token: @users[1].session.access_token, format: :json,
        user_game: {nickname: 'nickname', game_id: @games[0].id}
      expect(response.status).to eql(200)
      expect(@users[1].games.count).to eql(1)
    end
  end

  describe 'PATCH #update' do
    it "updates user's nick" do
      patch :update, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[0].session.access_token, format: :json,
        user_game: {nickname: 'nick'}
      expect(response.status).to eql(200)
      expect(@user_games[0].reload.nickname).to eql('nick')
    end

    it "doesn't update other user's nickname" do
      patch :update, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[1].session.access_token, format: :json,
        user_game: {nickname: 'nick'}
      expect(response.status).to eql(403)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes game from user' do
      delete :destroy, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[0].session.access_token, format: :json
      expect(response.status).to eql(200)
      expect(@users[0].games.count).to eql(1)
    end

    it "doesn't delete other user's game" do
      delete :destroy, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[1].session.access_token, format: :json
      expect(response.status).to eql(403)
    end
  end
end
