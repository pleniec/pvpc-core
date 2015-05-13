require 'rails_helper'

RSpec.describe Api::V1::UserGamesController do
  include_examples 'unauthenticated',
                   index: {method: :get},
                   create: {method: :post},
                   update: {method: :patch, id: 1},
                   destroy: {method: :delete, id: 1}

  context 'authenticated' do
    include_context 'authenticated'

    before do
      @games = FactoryGirl.create_list(:game, 3)
    end

    describe 'POST #create' do
      it 'adds game to user' do
        post :create, id: @games[0], nickname: 'trol', access_token: @access_token
        expect(response.status).to eql(200)
      end
    end

    describe 'PATCH #update' do
    end

    describe 'DELETE #destroy' do
    end
  end
end
