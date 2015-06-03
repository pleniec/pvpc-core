require 'rails_helper'

RSpec.describe API::V1::TeamsController do
  include_context 'authenticated'
  include_context 'flush_redis'

  before do
    @teams = FactoryGirl.create_list(:team, 5, founder: @users[0])
  end

  describe 'GET #index' do
    it 'renders teams' do
      get :index, access_token: @users[0].session.access_token, format: :json
      expect(response.status).to eql(200)

      response_body = JSON.parse(response.body)
      expect(response_body.size).to eql(@teams.size)

      keys = ['id', 'name']
      response_body.each do |team|
        expect(team.keys).to eql(keys)
        keys.each do |key|
          expect(team[key]).not_to be nil
        end
      end
    end

    it 'paginates teams' do
      get :index, access_token: @users[0].session.access_token, format: :json, offset: 2, limit: 2
      expect(response.status).to eql(200)

      response_body = JSON.parse(response.body)
      expect(response_body.size).to eql(2)

      expect(response_body[0]['id']).to eql(@teams[2].id)
      expect(response_body[1]['id']).to eql(@teams[3].id)
    end
  end

  describe 'GET #show' do
    it 'renders single team' do
      get :show, access_token: @users[0].session.access_token, format: :json, id: @teams[0].id
      expect(response.status).to eql(200)

      response_body = JSON.parse(response.body)
      keys = ['id', 'name', 'description', 'tag', 'founder']
      response_body.keys.each do |key|
        expect(response_body[key]).not_to be nil
      end
      expect(response_body['id']).to eql(@teams[0].id)
    end
  end

  describe 'POST #create' do
    it 'creates team' do
      post :create, access_token: @users[1].session.access_token, format: :json,
        team: FactoryGirl.attributes_for(:team, founder_id: @users[1].id)
      expect(response.status).to eql(200)

      expect(Team.count).to eql(6)
      expect(@users[1].team_memberships.count).to eql(1)
    end

    it 'cannot create team to other user' do
      post :create, access_token: @users[1].session.access_token, format: :json,
        team: FactoryGirl.attributes_for(:team, founder_id: @users[0].id)
      expect(response.status).to eql(403)
    end
  end
end
