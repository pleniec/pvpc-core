json.merge! @model.to_builder(controller_name.to_sym, action_name.to_sym).attributes!
