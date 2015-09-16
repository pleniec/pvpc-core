require 'rails_helper'

RSpec.describe TeamMembershipsController do
  before do
    @founder = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, founder: @founder)
    @users = FactoryGirl.create_list(:user, 3)
  end

  describe '#create' do
    it 'adds user to team' do
      create access_token: @founder.session.access_token,
        user_id: @users[0].id, team_id: @team.id
      expect(response.status).to eql(201)
      expect(@team.team_memberships.count).to eql(2)
    end

    it 'allows only founder to add to team' do
      create access_token: @users[0].session.access_token,
        user_id: @users[0].id, team_id: @team.id
      expect(response.status).to eql(403)
      expect(@team.team_memberships.count).to eql(1)
    end
  end

  describe '#index' do
    context 'with access_token parameter' do
      it 'renders team members' do
        index access_token: @users[0].session.access_token, team_id: @team.id

        expect(response_body['models'].size).to eql(1)
      end
    end

    context 'without access_token parameter' do
      it 'renders team members' do
        index team_id: @team.id

        expect(response_body['models'].size).to eql(1)
      end
    end
  end
end
