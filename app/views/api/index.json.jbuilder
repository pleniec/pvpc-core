json.array! @models do |model|
  json.merge! model.to_builder.attributes!
end
