class ConversationParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  scope :user_id, ->(user_id) { where(user_id: user_id) }
end
