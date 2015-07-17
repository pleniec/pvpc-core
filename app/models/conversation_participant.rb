class ConversationParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true

  scope :user_id, ->(user_id) { where(user_id: user_id) }

  def to_builder
    Jbuilder.new do |json|
      json.id
      json.conversation do
        json.merge! conversation.to_builder.attributes!
      end
    end
  end
end
