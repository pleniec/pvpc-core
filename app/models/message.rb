class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true
  validates :conversation, presence: true
  validates :text, presence: true

  has_scope :conversation_id, ->(conversation_id) { where(conversation_id: conversation_id) }
end
