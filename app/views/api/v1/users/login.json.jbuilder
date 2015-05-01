if @user
  json.id @user.id
  json.email @user.email
  json.access_token @user.access_token
else
  json.email ['invalid credentials']
end
