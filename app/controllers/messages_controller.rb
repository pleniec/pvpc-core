class MessagesController < ApplicationController
  has_scope :conversation_id, :limit, :offset
end
