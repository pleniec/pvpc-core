require 'rails_helper'

RSpec.describe API::V1::GamesController do
  include_context 'authenticated'
  include_context 'flush_redis'

  describe 'GET #index' do
    before do
      FactoryGirl.create_list(:game, 3)
    end
    
    it 'renders games' do
      get :index, access_token: @users[0].session.access_token, format: :json
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).size).to eql(3)
    end
  end
end
