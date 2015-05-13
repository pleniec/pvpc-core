require 'rails_helper'

RSpec.describe Api::V1::UserGamesController do
  context 'authenticated' do
    include_context 'authenticated'

    before do
      @game = FactoryGirl.create(:game)
    end

    describe 'POST #create' do
      it 'adds game to user' do
        post :create, id: @game.id, user_game: {nickname: 'trol'}, access_token: @current_user.access_token
        expect(response.status).to eql(200)
      end
    end

    context 'with one game created' do
      before do
        UserGame.create!(user_id: @current_user.id, game_id: @game.id, nickname: 'trol')
      end

      describe 'GET #index' do
        it 'shows user games' do
          get :index, access_token: @current_user.access_token, format: :json
          expect(response.status).to eql(200)
        end
      end

      describe 'PATCH #update' do
        it "updates user's nickname in game" do
          patch :update, id: @game.id, user_game: {nickname: 'trolek'}, access_token: @current_user.access_token
          expect(@current_user.user_games[0].nickname).to eql('trolek')
        end
      end

      describe 'DELETE #destroy' do
        it 'deletes game from user' do
          delete :destroy, id: @game.id, access_token: @current_user.access_token
          expect(@current_user.games.any?).to be false
        end
      end
    end
  end
end
