json.array! @users do |user|
  json.merge! user.to_builder.attributes!
end
