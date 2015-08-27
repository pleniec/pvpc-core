class Notification < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  validates :user, presence: true
  validates :type, presence: true, inclusion: {in: %w[NEW_FRIENDSHIP_INVITE
                                                      NEW_FRIENDSHIP]}
  validates :properties, presence: true

  scope :user_id, ->(user_id) { where(user_id: user_id) }
  scope :created_at, ->(created_at) { where(created_at: created_at) }
  scope :checked, ->(checked) { where(checked: checked) }

  def self.check!(notification_ids)
    Notification.transaction do
      notifications = Notification.find(notification_ids)
      notifications.each { |n| n.update!(checked: true) }
    end
  end
end
