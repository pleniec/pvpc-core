require 'rails_helper'

RSpec.describe API::V1::GamesController do
  before do
    @games = FactoryGirl.create_list(:game, 3)
  end

  describe 'GET #index' do
    it 'renders games' do
      get_json :index, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(3)
    end
  end

  describe 'GET #show' do
    it 'renders single game' do
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      get_json :show, access_token: @users[0].session.access_token, id: @games[1].id
      expect(response.status).to eql(200)
      expect(response_body['id']).to eql(@games[1].id)
    end
  end
end
