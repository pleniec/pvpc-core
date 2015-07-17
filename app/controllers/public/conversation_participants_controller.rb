module Public
  class ConversationParticipantsController < APIController
    has_scope :user_id
  end
end
