require 'rails_helper'

RSpec.describe API::V1::FriendshipsController do
  include_context 'authenticated'
  include_context 'flush_redis'

  before do
    FriendshipInvite.create!(from: @users[1], to: @users[0]).accept!
    FriendshipInvite.create!(from: @users[2], to: @users[0]).accept!
  end

  describe 'GET #index' do
    it "renders user's friends" do
      get :index, user_id: @users[0].id, access_token: @users[0].session.access_token, format: :json
      expect(JSON.parse(response.body).size).to eql(2)
    end
  end

  describe 'DELETE #destroy' do
    it "destroys user's friendship" do
      delete :destroy, user_id: @users[0].id, id: @users[0].friendships[0], access_token: @users[0].session.access_token,
        format: :json
      expect(@users[0].friendships.count).to eql(1)
    end
  end
end
