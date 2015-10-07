class NotificationsController < ApplicationController
  has_scope :user_id, :created_at, :checked, :limit, :offset

  def index
    authorize! :index, Notification
    render json: index_query, meta: {total: index_query.offset(nil).limit(nil).count,
                                     total_unchecked: current_user.notifications.where(checked: false).count},
           serializer: ArraySerializer, each_serializer: NotificationSerializer,
           scope: current_user
  end

  protected

  def update_params
    params.permit(:checked)
  end
end
