class NotificationsController < APIController
  def check
    Notification.find(notification_ids).each { |n| authorize! :check, n }
    Notification.where(id: notification_ids).update_all(checked: true)
    render nothing: true
  end
end
