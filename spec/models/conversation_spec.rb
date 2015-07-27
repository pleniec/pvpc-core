require 'rails_helper'

RSpec.describe Conversation do
  before do
    @users = FactoryGirl.create_list(:user, 5)
  end

  it 'validates number of conversation participants' do
    conversation = Conversation.new(conversation_participants_attributes: [{user_id: @users[0].id}])
    expect(conversation.valid?).to be false
    expect(conversation.errors[:conversation_participants].size).to eql(1)
  end

  it 'creates key on create' do
    conversation = Conversation.new(conversation_participants_attributes: [{user_id: @users[0].id},
                                                                           {user_id: @users[1].id}])
    conversation.save!
    expect(/^private:\d+:\d+$/.match(conversation.key)).not_to be nil
  end

  it 'validates uniqueness of key' do
    Conversation.new(conversation_participants_attributes: [{user_id: @users[0].id},
                                                            {user_id: @users[1].id}]).save!
    conversation = Conversation.new(conversation_participants_attributes: [{user_id: @users[0].id},
                                                                           {user_id: @users[1].id}])
    expect(conversation.valid?).to be false
    expect(conversation.errors[:conversation_participants].size).to eql(1)
  end

  it 'synchronizes with redis' do
    conversation = Conversation.create!(conversation_participants_attributes: [{user_id: @users[0].id},
                                                                               {user_id: @users[1].id}])
    conversation_participant_ids = Redis.current.smembers("chat:conversation:#{conversation.id}")
    expect(conversation_participant_ids.include?(@users[0].id))
    expect(conversation_participant_ids.include?(@users[1].id))
  end
end
