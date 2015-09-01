class NotificationsController < APIController
  has_scope :user_id, :created_at, :checked, :limit, :offset

  def index
    super
    @total_unchecked = current_user.notifications.where(checked: false).count
  end

  def check
    Notification.find(notification_ids).each { |n| authorize! :check, n }
    Notification.where(id: notification_ids).update_all(checked: true)
    render nothing: true
  end
end
