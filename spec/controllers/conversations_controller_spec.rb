require 'rails_helper'

RSpec.describe ConversationsController do
  before do
    @users = FactoryGirl.create_list(:user, 3)
  end

  describe 'POST #create' do
    it 'creates conversation' do
      post_json :create, access_token: @users[0].session.access_token,
        conversation_participants_attributes: [{user_id: @users[0].id}, {user_id: @users[1].id}]
      expect(response.status).to eql(201)
      expect(Conversation.count).to eql(1)
    end

    it 'does not allow duplicates' do
      Conversation.create!(conversation_participants_attributes: [{user_id: @users[0].id},
                                                                  {user_id: @users[1].id}])
      post_json :create, access_token: @users[0].session.access_token,
        conversation_participants_attributes: [{user_id: @users[1].id}, {user_id: @users[0].id}]
      expect(response.status).to eql(422)
    end

    it 'allows only user to create his conversations' do
      post_json :create, access_token: @users[0].session.access_token,
        conversation_participants_attributes: [{user_id: @users[1].id}, {user_id: @users[2].id}]
      expect(response.status).to eql(403)
    end
  end
end
