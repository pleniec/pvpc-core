if @user
  json.id @user.id
else
  json.id nil
end
