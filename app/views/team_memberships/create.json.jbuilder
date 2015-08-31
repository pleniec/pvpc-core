json.id @model.id
json.user { json.partial! 'partials/user/simple', model: @model.user }
json.team do
  json.id @model.team.id
  json.nickname @model.team.nickname
end
