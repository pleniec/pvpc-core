require 'rails_helper'

RSpec.describe TeamMembershipRequestsController do
  before do
    @team = FactoryGirl.create(:team)
    @user = FactoryGirl.create(:user)
  end

  describe '#index' do
    before { TeamMembershipRequest.create!(team: @team, from_user: @user) }

    context 'without parameters' do
      it 'renders forbidden status' do
        index access_token: @user.session.access_token

        expect(response.status).to eql 403
      end
    end

    context 'with permitted team_id parameter' do
      it 'renders team membership requests' do
        index access_token: @team.founder.session.access_token,
          team_id: @team.id

        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql 1
      end
    end

    context 'with forbidden team_id parameter' do
      it 'renders forbidden status' do
        index access_token: @user.session.access_token,
          team_id: @team.id

        expect(response.status).to eql 403
      end
    end
  end

  describe '#create' do
    context 'with permitted team_id' do
      it 'sends invite to user' do
        create access_token: @user.session.access_token,
          team_id: @team.id, from_user_id: @user.id

        expect(@team.team_membership_requests.count).to eql 1
      end
    end

    context 'with forbidden team_id' do
      it 'renders forbidden status' do
        create access_token: @team.founder.session.access_token,
          team_id: @team.id, from_user_id: @user.id

        expect(response.status).to eql 403
      end
    end

    context 'with already invited user id' do
      it 'renders unprocessable entity status' do
        TeamMembershipRequest.create!(team: @team, from_user: @user)

        create access_token: @user.session.access_token,
          team_id: @team.id, from_user_id: @user.id

        expect(response.status).to eql 422
      end
    end

    context 'with team member id' do
      it 'renders unprocessable entity status' do
        TeamMembershipInvite.create!(team: @team, to_user: @user).accept!

        create access_token: @user.session.access_token,
          team_id: @team.id, from_user_id: @user.id

        expect(response.status).to eql 422
      end
    end
  end

  describe '#destroy' do
    before do
      @team_membership_request = TeamMembershipRequest.create!(team: @team,
                                                               from_user: @user)
    end

    context 'with permitted id parameter' do
      it 'destroys team membership request' do
        destroy access_token: @team.founder.session.access_token,
          id: @team_membership_request.id

        expect(@team.team_membership_requests.count).to eql 0
      end
    end

    context 'with forbidden id parameter' do
      it 'renders forbidden status' do
        destroy access_token: @user.session.access_token,
          id: @team_membership_request.id

        expect(response.status).to eql 403
      end
    end
  end

  describe '#accept' do
    before do
      @team_membership_request = TeamMembershipRequest.create!(team: @team,
                                                               from_user: @user)
    end

    context 'with permitted id parameter' do
      it 'accepts team membership request' do
        post_json :accept, access_token: @team.founder.session.access_token,
          id: @team_membership_request.id

        expect(@team.users).to include(@user)
      end
    end

    context 'with forbidden id parameter' do
      it 'renders forbidden status' do
        post_json :accept, access_token: @user.session.access_token,
          id: @team_membership_request.id

        expect(response.status).to eql 403
      end
    end
  end
end
