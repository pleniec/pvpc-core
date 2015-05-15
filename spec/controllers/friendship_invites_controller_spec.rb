require 'rails_helper'

RSpec.describe Api::V1::FriendshipInvitesController do
  include_context 'authenticated'

  before do
    FriendshipInvite.create!(from: @users[0], to: @users[1])
    FriendshipInvite.create!(from: @users[2], to: @users[1])
    FriendshipInvite.create!(from: @users[1], to: @users[0])
  end

  describe 'GET #index' do
    it 'renders friendship invites' do
      get :index, user_id: @users[0].id, access_token: @users[0].access_token, format: :json
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body).size).to eql(1)
    end
  end

  describe 'POST #create' do
    it 'sends invite' do
      post :create, user_id: @users[0].id, access_token: @users[0].access_token, format: :json,
        friendship_invite: {to_user_id: @users[2].id}
      expect(response.status).to eql(200)
      expect(@users[2].friendship_invites.count).to eql(1)
    end

    it "doesn't send duplicates" do
      post :create, user_id: @users[0].id, access_token: @users[0].access_token, format: :json,
        friendship_invite: {to_user_id: @users[1].id}
      expect(response.status).to eql(422)
    end
  end

  describe 'PATCH #update' do
  end

  describe 'DELETE #destroy' do
  end
end
