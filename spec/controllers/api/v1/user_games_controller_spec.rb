require 'rails_helper'

RSpec.describe API::V1::UserGamesController do
  before do
    @games = FactoryGirl.create_list(:game, 4).to_a
    @user_games = @games[0..1].map do |game|
      FactoryGirl.create(:user_game, user: @users[0], game: game)
    end
  end

  describe 'GET #index' do
    it "renders user's games" do
      get_json :index, user_id: @users[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(2)
    end
  end

  describe 'POST #create' do
    it 'adds game to user' do
      post_json :create, user_id: @users[0].id, access_token: @users[0].session.access_token,
        user_game: {nickname: 'nickname', game_id: @games[2].id}
      expect(response.status).to eql(200)
      expect(@users[0].games.count).to eql(3)
    end

    it 'does not add duplicates' do
      post_json :create, user_id: @users[0].id, access_token: @users[0].session.access_token,
        user_game: {nickname: 'nickname', game_id: @games[0].id}
      expect(response.status).to eql(422)
      expect(@users[0].games.count).to eql(2)
    end

    it 'adds game to other user' do
      post_json :create, user_id: @users[1].id, access_token: @users[1].session.access_token,
        user_game: {nickname: 'nickname', game_id: @games[0].id}
      expect(response.status).to eql(200)
      expect(@users[1].games.count).to eql(1)
    end

    it 'cannot add game to other user' do
      post_json :create, user_id: @users[1].id, access_token: @users[0].session.access_token,
        user_game: {nickname: 'nickname', game_id: @games[0].id}
      expect(response.status).to eql(403)
      expect(@users[0].games.count).to eql(2)
    end
  end

  describe 'PATCH #update' do
    it "updates user's nick" do
      patch_json :update, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[0].session.access_token,
        user_game: {nickname: 'nick'}
      expect(response.status).to eql(200)
      expect(@user_games[0].reload.nickname).to eql('nick')
    end

    it "cannot update other user's nickname" do
      patch_json :update, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[1].session.access_token,
        user_game: {nickname: 'nick'}
      expect(response.status).to eql(403)
      expect(@user_games[0].reload.nickname).not_to eql('nick')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes game from user' do
      delete_json :destroy, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(@users[0].games.count).to eql(1)
    end

    it "doesn't delete other user's game" do
      delete_json :destroy, user_id: @users[0].id, id: @user_games[0].id, access_token: @users[1].session.access_token
      expect(response.status).to eql(403)
      expect(@users[0].games.count).to eql(2)
    end
  end
end
