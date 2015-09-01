require 'rails_helper'

RSpec.describe NotificationsController do
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
end
