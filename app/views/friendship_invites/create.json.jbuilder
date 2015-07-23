json.id @model.id
json.to_user do
  json.id @model.to_user.id
  json.email @model.to_user.email
  json.nickname @model.to_user.nickname
end
