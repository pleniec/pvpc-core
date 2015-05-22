json.array! @friendship_invites do |friendship_invite|
  json.merge! friendship_invite.to_builder.attributes!
end
