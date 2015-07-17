require 'rails_helper'

RSpec.describe Public::GamesController do
  describe 'pagination' do
    before do
      @games = FactoryGirl.create_list(:game, 5)
    end

    it 'renders all games' do
      get_json :index
      expect(response.status).to eql(200)
      expect(response_body['total']).to eql(5)
      expect(response_body['models'].size).to eql(5)

      (0...5).each do |i|
        expect(response_body['models'][i]['id']).to eql(@games[i].id)
      end
    end

    it 'renders games with offset' do
      get_json :index, offset: 2
      expect(response.status).to eql(200)
      expect(response_body['total']).to eql(5)
      expect(response_body['models'].size).to eql(3)

      (2...5).each do |i|
        expect(response_body['models'][i - 2]['id']).to eql(@games[i].id)
      end
    end

    it 'renders games with limit' do
      get_json :index, limit: 2
      expect(response.status).to eql(200)
      expect(response_body['total']).to eql(5)
      expect(response_body['models'].size).to eql(2)

      (0...2).each do |i|
        expect(response_body['models'][i]['id']).to eql(@games[i].id)
      end
    end

    it 'renders games with limit and offset' do
      get_json :index, offset: 2, limit: 2
      expect(response.status).to eql(200)
      expect(response_body['total']).to eql(5)
      expect(response_body['models'].size).to eql(2)

      (2...4).each do |i|
        expect(response_body['models'][i - 2]['id']).to eql(@games[i].id)
      end
    end
  end
end
