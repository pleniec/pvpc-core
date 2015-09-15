json.id model.id
json.email model.email
json.nickname model.nickname
json.relation_to_current_user model.relation_to_user(current_user) if current_user
json.image_url model.image_url
