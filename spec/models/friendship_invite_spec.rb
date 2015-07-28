require 'rails_helper'

RSpec.describe FriendshipInvite do
  before do
    @users = FactoryGirl.create_list(:user, 2)
  end

  it 'cannot invite the same user multiple times' do
    FriendshipInvite.create!(from_user: @users[0], to_user: @users[1])
    friendship_invite = FriendshipInvite.new(from_user: @users[0], to_user: @users[1])
    expect(friendship_invite.valid?).to be false
  end

  it 'rejects user inviting himself' do
    expect(FriendshipInvite.new(from_user: @users[0], to_user: @users[0]).valid?).to be false
  end

  it 'can be accepted' do
    FriendshipInvite.create!(from_user: @users[0], to_user: @users[1]).accept!
    expect(FriendshipInvite.count).to eql(0)
    expect(@users[0].friends.count).to eql(1)
    expect(@users[1].friends.count).to eql(1)
  end

  it 'rejects inviting friends' do
    FriendshipInvite.create!(from_user: @users[0], to_user: @users[1]).accept!
    expect(FriendshipInvite.new(from_user: @users[0], to_user: @users[1]).valid?).to be false
    expect(FriendshipInvite.new(from_user: @users[1], to_user: @users[0]).valid?).to be false
  end
end
