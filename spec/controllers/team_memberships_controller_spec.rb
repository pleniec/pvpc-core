require 'rails_helper'

RSpec.describe Public::TeamMembershipsController do
  before do
    @founder = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, founder: @founder)
    @users = FactoryGirl.create_list(:user, 3)
  end

  describe 'POST #create' do
    it 'adds user to team' do
      post_json :create, access_token: @founder.session.access_token,
        model: {user_id: @users[0].id, team_id: @team.id}
      expect(response.status).to eql(201)
      expect(@team.team_memberships.count).to eql(2)
    end

    it 'allows only founder to add to team' do
      post_json :create, access_token: @users[0].session.access_token,
        model: {user_id: @users[0].id, team_id: @team.id}
      expect(response.status).to eql(403)
      expect(@team.team_memberships.count).to eql(1)
    end
  end

  describe 'GET #index' do
    it 'renders team members' do
      get_json :index, access_token: @users[0].session.access_token, team_id: @team.id
      expect(response.status).to eql(200)
      expect(response_body['models'].size).to eql(1)
    end
  end
end
