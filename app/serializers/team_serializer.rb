class TeamSerializer < ModelSerializer
  attributes :id, :name, :member_count, :tag, :image_url, :current_user_relation

  def current_user_relation
    scope.relation_to_team(object) if scope
  end
end
