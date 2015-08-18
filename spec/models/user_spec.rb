require 'rails_helper'

RSpec.describe User do
  describe '.nickname' do
    it 'returns users with matching nickname' do
      users = [FactoryGirl.create(:user, nickname: 'user01275'),
               FactoryGirl.create(:user, nickname: 'user175751751'),
               FactoryGirl.create(:user, nickname: 'user1410751'),
               FactoryGirl.create(:user, nickname: 'NOPE!')]

      found_users = User.nickname('user').to_a

      expect(found_users.sort_by(&:id)).to eql users[0..2].sort_by(&:id)
    end
  end

  describe '.strangers_to_user_id' do
    it 'returns users that are not friends with specified user' do
      users = FactoryGirl.create_list(:user, 5)
      FriendshipInvite.create!(from_user: users[0], to_user: users[1]).accept!
      FriendshipInvite.create!(from_user: users[0], to_user: users[2]).accept!

      found_users = User.strangers_to_user_id(users[0].id)

      expect(found_users.sort_by(&:id)).to eql users[3..4].sort_by(&:id)
    end
  end

  describe '.authenticate' do
    before { @user = FactoryGirl.create(:user) }

    context 'when credentials are valid' do
      it 'returns user that matches credentials' do
        user = User.authenticate(@user.email, 'password123')

        expect(user).to eql @user
      end
    end

    context 'when credentials are invalid' do
      it 'returns nil' do
        user = User.authenticate(@user.email, 'BAD_PASSWORD')

        expect(user).to be nil
      end
    end
  end
end
