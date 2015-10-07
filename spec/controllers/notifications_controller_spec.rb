require 'rails_helper'

RSpec.describe NotificationsController do
  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:notification, user: user) },
                   permitted_params: ->(model) { {user_id: model.user_id, created_at: model.created_at,
                                                  checked: model.checked} },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:notification) },
                   forbidden_params: ->(model) { {user_id: model.user_id, created_at: model.created_at,
                                                  checked: model.checked} }

  include_examples :update, params: {'checked' => true},
                   create_permitted_model: ->(user) { FactoryGirl.create(:notification, user: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:notification) }

  describe '#update' do
    context 'when user tries to uncheck notification' do
      it 'renders validation error' do
        user = FactoryGirl.create(:user)
        notification = FactoryGirl.create(:notification, user: user, checked: true)

        update id: notification.id, access_token: user.session.access_token, checked: false

        expect(response.status).to eql 422
      end
    end
  end

  #:user_id, :created_at, :checked, :limit, :offset
=begin
include_examples :index,
               create_permitted_model: ->(user) { FactoryGirl.create(:game) },
               permitted_params: ->(model) { {} }


  describe '#index' do
    before do
      @users = FactoryGirl.create_list(:user, 5)
      FriendshipInvite.create!(from_user: @users[1], to_user: @users[0])
      FriendshipInvite.create!(from_user: @users[2], to_user: @users[0])
      FriendshipInvite.create!(from_user: @users[3], to_user: @users[0]).accept!
      FriendshipInvite.create!(from_user: @users[4], to_user: @users[0]).accept!
    end

    context 'without parameters' do
      it 'renders forbidden status' do
        index access_token: @users[0].session.access_token

        expect(response.status).to eql 403
      end
    end

    context 'with permitted user_id parameter' do
      it "renders user's notifications" do
        index access_token: @users[0].session.access_token, user_id: @users[0].id

        expect(response_body['models'].size).to eql 6
      end
    end
  end
=end
end
