json.id @model.id
json.nickname @model.nickname
json.game { json.partial! 'partials/game/simple', model: @model.game }
