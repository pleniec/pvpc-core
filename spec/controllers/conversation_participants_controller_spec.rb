require 'rails_helper'

RSpec.describe ConversationParticipantsController do
  describe '#index' do
    before { @user = FactoryGirl.create(:user) }

    context 'without parameters' do
      it 'renders forbidden status' do
        index access_token: @user.session.access_token

        expect(response.status).to eql 403
      end
    end

    context 'with permitted user_id parameter' do
      it "renders user's conversations" do
        users = FactoryGirl.create_list(:user, 3) 
        users.each { |u| Conversation.create!(conversation_participants_attributes: [{user_id: @user.id},
                                                                                     {user_id: u.id}]) }

        index access_token: @user.session.access_token, user_id: @user.id

        expect(response_body['models'].size).to eql 3
      end
    end

    context 'with forbidden user_id paremter' do
      it 'renders forbidden status' do
        other_user = FactoryGirl.create(:user)
        users = FactoryGirl.create_list(:user, 3)
        users.each { |u| Conversation.create!(conversation_participants_attributes: [{user_id: other_user.id},
                                                                                     {user_id: u.id}]) }

        index access_token: @user.session.access_token, user_id: other_user.id

        expect(response.status).to eql 403
      end
    end
  end
end
