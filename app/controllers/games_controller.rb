class GamesController < APIController
  skip_before_action :authenticate

  has_scope :offset, :limit
end
