class GamesController < APIController
  skip_before_action :authenticate

  has_scope :limit
  has_scope :offset
end
