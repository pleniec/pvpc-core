json.total @total
json.models @models do |model|
  json.id model.id
  json.type model.type
  json.user { json.partial! 'partials/user/simple', model: model.user }
  json.team { json.partial! 'partials/team/simple', model: model.team }
end
