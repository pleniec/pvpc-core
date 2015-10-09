class NotificationSerializer < ModelSerializer
  attributes :id, :type, :checked, :created_at, :data
end
