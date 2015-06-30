json.merge! @model.to_builder(access_token: true, settings_mask: true).attributes!
