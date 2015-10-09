require 'rails_helper'

RSpec.describe Friendship do
  describe '.create' do
    before do
      FactoryGirl.create(:friendship)
      @notification = Notification.first
    end

    it 'inserts valid attributes' do
      expect(@notification).not_to be_nil
      expect(@notification.type).to eql 'NEW_FRIENDSHIP'
      expect(@notification.data.keys).to include('friend')
      expect(@notification.data['friend']).not_to be_empty
    end

    it 'pushes notification to message queue' do
      _, _, message = MessageQueue.session.create_channel.basic_get('notifications')
      expect(@notification.to_json).to eql(message)
    end
  end
end
