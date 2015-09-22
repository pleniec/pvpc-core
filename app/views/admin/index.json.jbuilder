json.total @total
json.models @models do |model|
  json.merge! model.as_json
end
