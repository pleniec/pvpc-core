json.id @model.id
json.email @model.email
json.nickname @model.nickname
json.sex @model.sex
json.nationality @model.nationality
json.description @model.description
json.game_ownerships @model.game_ownerships do |game_ownership|
  json.id game_ownership.id
  json.game do
    json.id game_ownership.game.id
    json.name game_ownership.game.name
  end
end
