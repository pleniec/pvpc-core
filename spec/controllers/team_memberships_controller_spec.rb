require 'rails_helper'

RSpec.describe TeamMembershipsController do
  include_examples :authentication, restricted: {update: :patch, destroy: :delete}, free: {index: :get}

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:team_membership) },
                   permitted_params: ->(model) { {user_id: model.user_id, team_id: model.team_id} }

  include_examples :update, params: {captain: true},
                   create_permitted_model: ->(user) { FactoryGirl.create(:team_membership, team: FactoryGirl.create(:team, founder: user)) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership) }

  include_examples :destroy,
                   create_permitted_model: ->(user) { FactoryGirl.create(:team_membership, team: FactoryGirl.create(:team, founder: user)) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership) }

  describe '#destroy' do
    context 'when founder wants to remove himself from team' do
      it 'renders errors' do
        user = FactoryGirl.create(:user)
        team_membership = FactoryGirl.create(:team_membership, user: user, team: FactoryGirl.create(:team, founder: user))

        destroy id: team_membership.id, access_token: user.session.access_token

        expect(response.status).to eql 422
      end
    end
  end
end