require 'rails_helper'

RSpec.describe FriendshipsController do
  before do
    @users = FactoryGirl.create_list(:user, 3)
    FriendshipInvite.create!(from_user: @users[1], to_user: @users[0]).accept!
    FriendshipInvite.create!(from_user: @users[2], to_user: @users[0]).accept!
    FriendshipInvite.create!(from_user: @users[1], to_user: @users[2]).accept!
  end

  describe 'GET #index' do
    it "renders user's friends" do
      get_json :index, user_id: @users[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(2)
    end
  end

  describe 'DELETE #destroy' do
    it 'ends friendship' do
      delete_json :destroy, user_id: @users[0].id, id: @users[0].friendships[0].id,
        access_token: @users[0].session.access_token
      expect(response.status).to eql(204)
      expect(@users[0].friendships.count).to eql(1)
    end

    it "cannot end other user's friendship" do
      delete_json :destroy, user_id: @users[1].id, id: @users[1].friendships[1].id,
        access_token: @users[0].session.access_token
      expect(response.status).to eql(403)
    end
  end
end
