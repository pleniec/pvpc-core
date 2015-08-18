require 'rails_helper'

RSpec.describe User do
  describe 'model' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'has access token after create' do
      expect(@user.session.access_token).to_not be nil
    end

    it 'has flags' do
      expect(@user.flags.to_h).to_not be nil
    end

    it 'can update flags' do
      @user.flags.play_message_sound = true
      @user.save!

      expect(User.find(@user.id).flags.play_message_sound).to be true
    end
  end

  describe 'scope' do
    describe 'nickname' do
      it 'returns users with matching nickname' do
        users = [FactoryGirl.create(:user, nickname: 'user01275'),
                 FactoryGirl.create(:user, nickname: 'user175751751'),
                 FactoryGirl.create(:user, nickname: 'user1410751'),
                 FactoryGirl.create(:user, nickname: 'NOPE!')]
        found_users = User.nickname('user').to_a
        expect(found_users.sort_by(&:id)).to eql users[0..2].sort_by(&:id)
      end
    end

    describe 'strangers_to_user_id' do
      it 'returns users that are not friends with specified user' do
        users = FactoryGirl.create_list(:user, 5)
        FriendshipInvite.create!(from_user: users[0], to_user: users[1]).accept!
        FriendshipInvite.create!(from_user: users[0], to_user: users[2]).accept!
        found_users = User.strangers_to_user_id(users[0].id)
        expect(found_users.sort_by(&:id)).to eql users[3..4].sort_by(&:id)
      end
    end
  end

  describe 'authentication' do
    it 'returns user on valid credentials' do
      user = FactoryGirl.create(:user)
      authentication_result = User.authenticate(user.email, 'password123')
      expect(authentication_result).to eql(user)
    end
  end
end
