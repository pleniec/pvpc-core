json.total @total
json.models @models do |model|
  json.id model.id
  json.text model.text
  json.created_at model.created_at
  json.updated_at model.updated_at
end