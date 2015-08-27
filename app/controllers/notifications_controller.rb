class NotificationsController < APIController
  def check
    Notification.check!(params[:notification_ids])
    render nothing: true
  end
end
