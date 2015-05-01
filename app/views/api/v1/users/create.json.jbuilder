if @user.errors.empty?
  json.id @user.id
  json.email @user.email
  json.access_token @user.access_token
else
  @user.errors.messages.each do |attribute, errors|
    json.set! attribute, errors
  end
end
