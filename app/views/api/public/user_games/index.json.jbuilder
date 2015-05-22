json.array! @user_games do |user_game|
  json.merge! user_game.to_builder.attributes!
end
