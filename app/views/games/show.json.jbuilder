json.id @model.id
json.name @model.name
json.rules @model.rules do |rule|
  json.id rule.id
  json.name rule.name
  json.entries rule.entries do |entry|
    json.id entry.id
    json.key entry.key
    json.value entry.value
  end
end
