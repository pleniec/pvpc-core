json.total @total
json.models @models do |model|
  json.id model.id
  json.friend { json.partial! 'partials/user/simple', model: model.friend }
end
