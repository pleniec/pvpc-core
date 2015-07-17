class ConversationParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true

  scope :user_id, ->(user_id) { where(user_id: user_id) }

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id
      json.conversation do
        json.merge! conversation.to_builder(controller, action).attributes!
      end
    end
  end
end
