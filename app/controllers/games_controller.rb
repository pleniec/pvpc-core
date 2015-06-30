class GamesController < APIController
  skip_before_action :authenticate
end
