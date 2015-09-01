class NotificationsController < APIController
  def index
    super
    @total_unchecked = current_user.notification.where(checked: false).count
  end

  def check
    Notification.find(notification_ids).each { |n| authorize! :check, n }
    Notification.where(id: notification_ids).update_all(checked: true)
    render nothing: true
  end
end
