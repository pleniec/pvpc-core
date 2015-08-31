json.id @model.id
json.to_user { json.partial! 'partials/user/simple', model: @model.to_user }
