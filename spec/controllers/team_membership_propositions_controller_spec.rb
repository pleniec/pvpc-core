require 'rails_helper'

RSpec.describe TeamMembershipPropositionsController do
  include_examples :authentication, restricted: {index: :get, create: :post, destroy: :delete, accept: :post}

  include_examples :create,
    permitted_params: ->(user) { FactoryGirl.build(:team_membership_proposition, user: user, type: 'REQUEST').attributes },
    forbidden_params: ->(user) { FactoryGirl.build(:team_membership_proposition, user: FactoryGirl.create(:user), type: 'REQUEST').attributes }

  include_examples :create,
    permitted_params: ->(user) { FactoryGirl.build(:team_membership_proposition, team: FactoryGirl.create(:team, founder: user), type: 'INVITE').attributes },
    forbidden_params: ->(user) { FactoryGirl.build(:team_membership_proposition, team: FactoryGirl.create(:team), type: 'INVITE').attributes }

  include_examples :index,
    create_permitted_model: ->(user) { FactoryGirl.create(:team_membership_proposition, user: user, type: 'INVITE') },
    permitted_params: ->(model) { {user_id: model.user.id, type: 'INVITE'} },
    create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership_proposition, type: 'INVITE') },
    forbidden_params: ->(model) { {user_id: model.user.id, type: 'INVITE'} }

  include_examples :index,
    create_permitted_model: ->(user) { FactoryGirl.create(:team_membership_proposition, team: FactoryGirl.create(:team, founder: user), type: 'REQUEST') },
    permitted_params: ->(model) { {team_id: model.team.id, type: 'REQUEST'} },
    create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership_proposition, type: 'INVITE') },
    forbidden_params: ->(model) { {user_id: model.team.id, type: 'REQUEST'} }

  include_examples :destroy,
    create_permitted_model: ->(user) { FactoryGirl.create(:team_membership_proposition, user: user, type: 'INVITE') },
    create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership_proposition, type: 'INVITE') }

  include_examples :destroy,
    create_permitted_model: ->(user) { FactoryGirl.create(:team_membership_proposition, team: FactoryGirl.create(:team, founder: user), type: 'REQUEST') },
    create_forbidden_model: ->(user) { FactoryGirl.create(:team_membership_proposition, team: FactoryGirl.create(:team), type: 'REQUEST') }

  describe '#accept' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to accept team membership proposition' do
      it 'accepts team membership proposition' do
        @team_membership_proposition = FactoryGirl.create(:team_membership_proposition, user: @user, type: 'INVITE')

        post_json :accept, access_token: @user.session.access_token, id: @team_membership_proposition.id

        expect(response.status).to eql 204
      end
    end

    context 'when unauthorized user attempts to destroy team membership proposition' do
      it 'renders forbidden status' do
        @team_membership_proposition = FactoryGirl.create(:team_membership_proposition, type: 'INVITE')

        post_json :accept, access_token: @user.session.access_token, id: @team_membership_proposition.id

        expect(response.status).to eql 403
      end
    end
  end
end
