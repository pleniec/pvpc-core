class Conversation < ActiveRecord::Base
  has_many :conversation_participants

  accepts_nested_attributes_for :conversation_participants

  validate :number_of_conversation_participants
  validate :uniqueness_of_participants_key

  before_create do
    self.key = 'private:' + conversation_participants.map(&:user_id).sort.join(':')
  end

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id id

      if action == :show
        json.conversation_participants conversation_participants do |conversation_participant|
          json.merge! conversation_participant.to_builder(controller, action).attributes!
        end
      end
    end
  end

  protected

  def number_of_conversation_participants
    if conversation_participants.size != 2
      errors[:conversation_participants] << 'must provide two models'
    end
  end

  def uniqueness_of_participants_key
    return if errors[:conversation_participants].any?
    if Conversation.where(key: 'private:' + conversation_participants.map(&:user_id).sort.join(':')).exists?
      errors[:conversation_participants] << 'already exists'
    end
  end
end
