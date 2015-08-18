require 'rails_helper'

RSpec.describe FriendshipInvite do
  describe 'model' do
    it 'can be accepted' do
      friendship_invite = FactoryGirl.create(:friendship_invite)
      friendship_invite.accept!
      expect(FriendshipInvite.count).to eql 0
      expect(friendship_invite.from_user.friends.count).to eql 1
      expect(friendship_invite.to_user.friends.count).to eql 1
    end
  end

  describe 'scope' do
    describe 'to_user_id' do
      it 'returns friendship invites sent to specified user' do
        user = FactoryGirl.create(:user)
        5.times { FactoryGirl.create(:friendship_invite, to_user: user) }
        found_friendship_invites = FriendshipInvite.to_user_id(user.id)
        expect(found_friendship_invites.size).to eql 5
      end
    end
  end

  describe 'validation' do
    before do
      @users = FactoryGirl.create_list(:user, 2)
    end

    it 'rejects inviting the same user multiple times' do
      FriendshipInvite.create!(from_user: @users[0], to_user: @users[1])
      expect(FriendshipInvite.new(from_user: @users[0], to_user: @users[1]).valid?).to be false
    end

    it 'rejects user inviting himself' do
      expect(FriendshipInvite.new(from_user: @users[0], to_user: @users[0]).valid?).to be false
    end

    it 'rejects inviting friends' do
      FriendshipInvite.create!(from_user: @users[0], to_user: @users[1]).accept!
      expect(FriendshipInvite.new(from_user: @users[0], to_user: @users[1]).valid?).to be false
      expect(FriendshipInvite.new(from_user: @users[1], to_user: @users[0]).valid?).to be false
    end

    it 'rejects responding to invite with invite' do
      FriendshipInvite.create!(from_user: @users[0], to_user: @users[1])
      expect(FriendshipInvite.new(from_user: @users[1], to_user: @users[0]).valid?).to be false
    end
  end
end
