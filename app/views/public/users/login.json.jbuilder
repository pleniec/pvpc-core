json.merge! @model.to_builder(access_token: true, settings_mask: true, game_ownerships: true).attributes!
