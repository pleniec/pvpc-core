json.total @total
json.models @models do |model|
  json.id model.id
  json.name model.name
  json.member_count model.users.count
end
