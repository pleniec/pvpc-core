json.id @model.id
json.team { json.partial! 'partials/team/simple', model: @model.team }
