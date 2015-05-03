json.id @game.id
json.name @game.name
json.description @game.description
json.icon @game.icon.url
json.image @game.image.url
json.rules @game.rules do |rule|
  json.id rule.id
  json.name rule.name
  json.entries rule.entries do |entry|
    json.key entry.key
    json.value entry.value
  end
end
