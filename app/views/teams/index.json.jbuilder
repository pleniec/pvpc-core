json.total @total
json.models @models do |model|
  json.id model.id
  json.name model.name
end
