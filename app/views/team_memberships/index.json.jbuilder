json.array! @team_memberships do |team_membership|
  json.merge! team_membership.to_builder.attributes!
end
