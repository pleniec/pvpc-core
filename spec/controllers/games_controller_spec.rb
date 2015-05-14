require 'rails_helper'

RSpec.describe Api::V1::GamesController do
  context 'authenticated' do
    include_context 'authenticated'

    describe 'GET #index' do
      before do
        FactoryGirl.create_list(:game, 3)
      end
      
      it 'renders games' do
        get :index, access_token: @users[0].access_token, format: :json
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body).size).to eql(3)
      end
    end
  end
end
