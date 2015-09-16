require 'rails_helper'

RSpec.describe CommentsController do
=begin
  include_examples :index,
                   create_permitted_model: ->(user) {},
                   permitted_params: ->(user, model) {},
                   create_forbidden_model: ->(user) {},
                   forbidden_params: ->(user, model) {}
  include_examples :destroy,
                   create_permitted_model: ->(user) { FactoryGirl.create(:comment, user: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:comment) }
  include_examples :create,
                   permitted_params: ->(user) { FactoryGirl.build(:comment, user: user).attributes },
                   forbidden_params: ->(user) { FactoryGirl.build(:comment).attributes }
=end

=begin
  include_examples :authentication, restricted: [:create, :update, :destroy], free: [:index]

  before do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team)
  end

  describe '#index' do
    before do
      FactoryGirl.create_list(:comment, 3, user: @user, commentable: @user)
      FactoryGirl.create_list(:comment, 2, user: @user, commentable: @team)
    end

    context 'with commentable (User) parameter' do
      it "returns user's comments" do
        index commentable_id: @user.id, commentable_type: 'User'

        expect(response_body['models'].size).to eql 3
      end
    end

    context 'with commentable (Team) parameter' do
      it "returns team's comments" do
        index commentable_id: @team.id, commentable_type: 'Team'

        expect(response_body['models'].size).to eql 2
      end
    end
  end

  describe '#create' do
    context 'with permitted user_id parameter' do
      it 'creates comment' do
        create access_token: @user.session.access_token, commentable_id: @team.id,
          commentable_type: 'Team', user_id: @user.id, text: 'noob'

        expect(@team.reload.comments.count).to eql 1
      end
    end

    context 'with forbidden user_id parameter' do
      it 'renders forbidden status' do
        other_user = FactoryGirl.create(:user)

        create access_token: other_user.session.access_token, commentable_id: @team.id,
          commentable_type: 'Team', user_id: @user.id, text: 'noob'

        expect(response.status).to eql 403
      end
    end

    context 'with forbidden commentable_type parameter' do
      it 'renders unprocessable entity status' do
        game = FactoryGirl.create(:game)

        create access_token: @user.session.access_token, commentable_id: game.id,
          commentable_type: 'Game', user_id: @user.id, text: 'noob'

        expect(response.status).to eql 422
      end
    end
  end
=end
end
