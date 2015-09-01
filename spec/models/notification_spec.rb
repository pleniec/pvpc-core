require 'rails_helper'

RSpec.describe Notification do
  describe '.user_id' do
    it 'returns notification of specified user' do
      @notifications = FactoryGirl.create_list(:notification, 3)

      expect(Notification.user_id(@notifications[1].user.id)[0]).to eql(@notifications[1])
    end
  end
end
