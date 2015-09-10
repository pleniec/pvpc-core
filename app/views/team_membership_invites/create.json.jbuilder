json.id @model.id
json.user { json.partial! 'partials/user/simple', model: @model.user }
