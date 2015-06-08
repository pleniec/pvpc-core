json.array! @game_ownerships do |game_ownership|
  json.merge! game_ownership.to_builder.attributes!
end
