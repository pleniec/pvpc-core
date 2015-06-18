json.merge! @user.to_builder(access_token: true, settings_mask: true).attributes!
