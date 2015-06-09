json.array! @teams do |team|
  json.merge! team.to_builder.attributes!
end
