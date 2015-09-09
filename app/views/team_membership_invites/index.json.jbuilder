json.total @total
json.models @models do |model|
  json.id model.id
  json.team { json.partial! 'partials/team/simple', model: model.team }
end
