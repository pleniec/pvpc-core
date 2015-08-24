json.id @model.id
json.nickname @model.nickname
json.description @model.description
json.tag @model.tag
json.founder do
  json.id @model.founder.id
  json.email @model.founder.email
  json.nickname @model.founder.nickname
end
