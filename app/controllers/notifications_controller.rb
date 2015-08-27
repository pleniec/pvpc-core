class NotificationsController < APIController
  def check
    notifications = Notification.find(params[:notification_ids])
    notifications.each { |n| n.update!(checked: true) }
    render nothing: true
  end
end
