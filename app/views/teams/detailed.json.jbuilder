json.id @model.id
json.name @model.name
json.description @model.description
json.tag @model.tag
json.founder do
  json.id @model.founder.id
  json.email @model.founder.email
  json.nickname @model.founder.nickname
end
json.member_count @model.users.count
