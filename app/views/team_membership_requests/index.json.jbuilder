json.total @total
json.models @models do |model|
  json.id model.id
  json.user { json.partial! 'partials/user/simple', model: model.user }
end
