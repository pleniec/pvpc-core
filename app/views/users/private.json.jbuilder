json.partial! 'partials/user/detailed', model: @model
json.access_token @model.session.access_token
json.flags do
  @model.flags.to_h.each do |attribute, value|
    json.set! attribute, value
  end
end
