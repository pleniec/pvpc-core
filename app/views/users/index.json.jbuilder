json.total @total
json.models @models do |model|
  json.partial! 'partials/user/simple', model: model
end
