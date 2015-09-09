json.total @total
json.models @models do |model|
  json.partial! 'partials/game/simple', model: model
end
