require 'rails_helper'

RSpec.describe Notification do
  describe '.check!' do
    before { @notifications = FactoryGirl.create_list(:notification, 3) }

    context 'when provided notification ids are valid' do
      it 'updates checked to true' do
        Notification.check!(@notifications.map(&:id))

        Notification.all.each do |notification|
          expect(notification.checked).to be true
        end
      end
    end

    context 'when provided notification ids are invalid' do
      it 'throws exception' do
        expect do
          Notification.check!(@notifications.map { |n| n.id + 100 })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '.user_id' do
    it 'returns notification of specified user' do
      @notifications = FactoryGirl.create_list(:notification, 3)

      expect(Notification.user_id(@notifications[1].user.id)[0]).to eql(@notifications[1])
    end
  end
end
