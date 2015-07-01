json.total @total
json.models @models do |model|
  json.merge! model.to_builder.attributes!
end
