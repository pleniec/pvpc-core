require 'rails_helper'

RSpec.describe Users::FriendshipInvite do
  before do
    @users = FactoryGirl.create_list(:user, 2)
  end

  it 'cannot invite the same user multiple times' do
    Users::FriendshipInvite.create!(from: @users[0], to: @users[1])
    expect do 
      Users::FriendshipInvite.create!(from: @users[0], to: @users[1])
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'rejects user inviting himself' do
    expect do
      Users::FriendshipInvite.create!(from: @users[0], to: @users[0])
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can be accepted' do
    Users::FriendshipInvite.create!(from: @users[0], to: @users[1]).accept!
    expect(Users::FriendshipInvite.count).to eql(0)
    expect(@users[0].friends.count).to eql(1)
    expect(@users[1].friends.count).to eql(1)
  end

  it 'rejects inviting friends' do
    Users::FriendshipInvite.create!(from: @users[0], to: @users[1]).accept!
    expect do
      Users::FriendshipInvite.create!(from: @users[0], to: @users[1])
    end.to raise_error(ActiveRecord::RecordInvalid)
    expect do
      Users::FriendshipInvite.create!(from: @users[1], to: @users[0])
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
