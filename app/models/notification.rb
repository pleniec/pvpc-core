class Notification < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  validates :user, presence: true
  validates :type, presence: true, inclusion: {in: %w[NEW_FRIENDSHIP_INVITE
                                                      NEW_FRIENDSHIP]}

  after_create do
    if MessageQueue.session.queue_exists?("notifications:#{user.id}")
      MessageQueue.session
        .create_channel
        .queue("notifications:#{user.id}")
        .publish({id: id, type: type, content: content.attributes!}.to_json)
    end
  end

  scope :user_id, ->(user_id) { where(user_id: user_id) }
  scope :created_at, ->(created_at) { where(created_at: created_at) }
  scope :checked, ->(checked) { where(checked: checked) }

  def content
    Jbuilder.new do |json|
      case type
      when 'NEW_FRIENDSHIP_INVITE'
        json.from_user do
          from_user = User.find_by_id(properties['from_user_id'])
          json.id from_user.try(:id)
          json.email from_user.try(:email)
          json.nickname from_user.try(:nickname)
        end
      when 'NEW_FRIENDSHIP'
        json.friend do
          friend = User.find_by_id(properties['friend_id'])
          json.id friend.try(:id)
          json.email friend.try(:email)
          json.nickname friend.try(:nickname)
        end
      end
    end
  end
end
