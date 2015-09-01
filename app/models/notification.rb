class Notification < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  validates :user, presence: true
  validates :type, presence: true, inclusion: {in: %w[NEW_FRIENDSHIP_INVITE
                                                      NEW_FRIENDSHIP]}

  scope :user_id, ->(user_id) { where(user_id: user_id) }
  scope :created_at, ->(created_at) { where(created_at: created_at) }
  scope :checked, ->(checked) { where(checked: checked) }

  def content
    Jbuilder.new do |json|
      case type
      when 'NEW_FRIENDSHIP_INVITE'
        json.from_user do
          from_user = User.find_by_id(properties['from_user_id'])
          json.id from_user.id
          json.email from_user.email
          json.nickname from_user.nickname
        end
      when 'NEW_FRIENDSHIP'
        json.friend do
          friend = User.find_by_id(properties['friend_id'])
          json.id friend.id
          json.email friend.email
          json.nickname friend.nickname
        end
      end
    end
  end
end
