json.id model.id
json.email model.email
json.nickname model.nickname
json.relation_to_current_user model.relation_to(current_user) if current_user
