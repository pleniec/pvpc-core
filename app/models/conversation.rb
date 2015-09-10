class Conversation < ActiveRecord::Base
  has_many :conversation_participants

  accepts_nested_attributes_for :conversation_participants

  validate :number_of_conversation_participants
  validate :uniqueness_of_participants_key

  before_create do
    self.key = 'private:' + conversation_participants.map(&:user_id).sort.join(':')
  end

  after_create :synchronize

  def synchronize
    key = "chat:conversation:#{id}"
    Cache.session.del(key)
    Cache.session.sadd(key, conversation_participants.map(&:user_id).to_a)
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
