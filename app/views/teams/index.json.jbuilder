json.total @total
json.models @models do |model|
  json.partial! 'partials/team/simple', model: model
end
