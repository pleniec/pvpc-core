require 'rails_helper'

RSpec.describe GamesController do
  before do
    @games = FactoryGirl.create_list(:game, 3)
  end

  describe 'GET #index' do
    it 'renders games' do
      index
      expect(response.status).to eql(200)
      expect(response_body['models'].size).to eql(3)
    end
  end

  describe 'GET #show' do
    it 'renders single game' do
      show id: @games[0].id
      expect(response.status).to eql(200)
      expect(response_body['id']).to eql(@games[0].id)
    end
  end
end
