json.id @model.id
json.user { json.partial! 'partials/user/simple', model: @model.user }
json.team do
  json.partial! 'partials/team/simple', model: @model.team
end
