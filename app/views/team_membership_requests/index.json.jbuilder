json.total @total
json.models @models do |model|
  json.id model.id
  json.from_user { json.partial! 'partials/user/simple', model: model.from_user }
end
