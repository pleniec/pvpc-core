json.array! @friendships do |friendship|
  json.merge! friendship.to_builder.attributes!
end
