class MessagesController < APIController
  has_scope :conversation_id, :limit, :offset
end
