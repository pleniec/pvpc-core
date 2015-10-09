class Notification < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  validates :user, presence: true
  validates :type, presence: true, inclusion: {in: %w[NEW_FRIENDSHIP_INVITE
                                                      NEW_FRIENDSHIP]}
  validate :cannot_uncheck_notification

  after_create { MessageQueue.notifications.publish(self.to_json) }

  scope :user_id, ->(user_id) { where(user_id: user_id) }
  scope :created_at, ->(created_at) { where(created_at: created_at) }
  scope :checked, ->(checked) { where(checked: checked) }

  private

  def cannot_uncheck_notification
    if checked_changed? && !checked
      errors[:checked] << 'cannot uncheck notification'
    end
  end
end
