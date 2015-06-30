require 'rails_helper'

RSpec.describe FriendshipInvitesController do
  before do
    @users = FactoryGirl.create_list(:user, 4)
      FriendshipInvite.create!(from_user: @users[1], to_user: @users[0])
      FriendshipInvite.create!(from_user: @users[2], to_user: @users[0])
      FriendshipInvite.create!(from_user: @users[1], to_user: @users[2])
  end

  describe 'POST #create' do
    it 'creates invite' do
      post_json :create, access_token: @users[0].session.access_token,
        friendship_invite: {from_user_id: @users[0].id, to_user_id: @users[3].id}
      expect(response.status).to eql(201)
      expect(@users[3].friendship_invites.count).to eql(1)
    end

    it 'cannot create invite as other user' do
      post_json :create, access_token: @users[0].session.access_token,
        friendship_invite: {from_user_id: @users[1].id, to_user_id: @users[3].id}
      expect(response.status).to eql(403)
      expect(@users[3].friendship_invites.count).to eql(0)
    end

    it 'cannot invite the same user multiple times' do
      FriendshipInvite.create!(from_user: @users[0], to_user: @users[3])
      post_json :create, access_token: @users[0].session.access_token,
        friendship_invite: {from_user_id: @users[0].id, to_user_id: @users[3].id}
      expect(response.status).to eql(422)
      expect(@users[3].friendship_invites.count).to eql(1)
    end

    it 'does not allow user to invite himself' do
      post_json :create, access_token: @users[0].session.access_token,
        friendship_invite: {from_user_id: @users[0].id, to_user_id: @users[0].id}
      expect(response.status).to eql(422)
      expect(@users[1].friendship_invites.count).to eql(0)
    end
  end

  describe 'GET #index' do
    it "renders user's invites" do
      get_json :index, access_token: @users[0].session.access_token, to_user_id: @users[0].id
      expect(response.status).to eql(200)
      expect(response_body.size).to eql(2)
    end

    it "cannot render other user's invites" do
      get_json :index, access_token: @users[0].session.access_token, to_user_id: @users[1].id
      expect(response.status).to eql(403)
    end
  end

  describe 'DELETE #destroy' do
    it 'declines invite' do
      delete_json :destroy, id: @users[0].friendship_invites[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(@users[0].friendship_invites.count).to eql(1)
    end

    it "cannot decline other user's invite" do
      delete_json :destroy, id: @users[2].friendship_invites[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(403)
      expect(@users[2].friendship_invites.count).to eql(1)
    end
  end

  describe 'POST #accept' do
    it 'accepts invite' do
      post_json :accept, id: @users[0].friendship_invites[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(200)
      expect(@users[0].friendships.count).to eql(1)
      expect(@users[1].friendships.count).to eql(1)
    end

    it "cannot accept other user's invite" do
      post_json :accept, id: @users[2].friendship_invites[0].id, access_token: @users[0].session.access_token
      expect(response.status).to eql(403)
    end
  end
end
