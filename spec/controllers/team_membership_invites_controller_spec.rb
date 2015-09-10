require 'rails_helper'

RSpec.describe TeamMembershipInvitesController do
  before do
    @team = FactoryGirl.create(:team)
    @user = FactoryGirl.create(:user)
  end

  describe '#index' do
    before do
      TeamMembershipInvite.create!(team: @team, user: @user)
    end

    context 'without parameters' do
      it 'renders forbidden status' do
        index access_token: @user.session.access_token

        expect(response.status).to eql 403
      end
    end

    context 'with permitted user_id parameter' do
      it "renders user's invites" do
        index access_token: @user.session.access_token,
          user_id: @user.id

        expect(response.status).to eql 200
        expect(response_body['models'].size).to eql 1
      end
    end

    context 'with forbidden user_id parameter' do
      it 'renders forbidden status' do
        index access_token: @team.founder.session.access_token,
          user_id: @user.id

        expect(response.status).to eql 403
      end
    end
  end

  describe '#create' do
    context 'with permitted team_id' do
      it 'sends invite to user' do
        create access_token: @team.founder.session.access_token,
          team_id: @team.id, user_id: @user.id

        expect(@user.received_team_membership_invites.count).to eql 1
      end
    end

    context 'with forbidden team_id' do
      it 'renders forbidden status' do
        create access_token: @user.session.access_token,
          team_id: @team.id, user_id: @user.id

        expect(response.status).to eql 403
      end
    end

    context 'with already invited user id' do
      it 'renders unprocessable entity status' do
        TeamMembershipInvite.create!(team: @team, user: @user)

        create access_token: @team.founder.session.access_token,
          team_id: @team.id, user_id: @user.id

        expect(response.status).to eql 422
      end
    end

    context 'with team member id' do
      it 'renders unprocessable entity status' do
        TeamMembershipInvite.create!(team: @team, user: @user).accept!

        create access_token: @team.founder.session.access_token,
          team_id: @team.id, user_id: @user.id

        expect(response.status).to eql 422
      end
    end
  end

  describe '#destroy' do
    before do
      @team_membership_invite = TeamMembershipInvite.create!(team: @team,
                                                             user: @user)
    end

    context 'with permitted id parameter' do
      it 'destroys team membership invite' do
        destroy access_token: @user.session.access_token,
          id: @team_membership_invite.id

        expect(@user.received_team_membership_invites.count).to eql 0
      end
    end

    context 'with forbidden id parameter' do
      it 'renders forbidden status' do
        destroy access_token: @team.founder.session.access_token,
          id: @team_membership_invite.id

        expect(response.status).to eql 403
      end
    end
  end

  describe '#accept' do
    before do
      @team_membership_invite = TeamMembershipInvite.create!(team: @team,
                                                             user: @user)
    end

    context 'with permitted id parameter' do
      it 'destroys team membership invite' do
        post_json :accept, access_token: @user.session.access_token,
          id: @team_membership_invite.id

        expect(@team.users).to include(@user)
      end
    end

    context 'with forbidden id parameter' do
      it 'renders forbidden status' do
        post_json :accept, access_token: @team.founder.session.access_token,
          id: @team_membership_invite.id

        expect(response.status).to eql 403
      end
    end
  end
end
