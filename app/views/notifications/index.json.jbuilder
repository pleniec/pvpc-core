json.total @total
json.total_unchecked @total_unchecked
json.models @models do |model|
  json.id model.id
  json.user_id model.user_id
  json.type model.type
  json.checked model.checked
  json.created_at model.created_at
  json.content { json.merge! model.content.attributes! }
end
