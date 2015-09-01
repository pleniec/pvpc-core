require 'factory_girl_rails'

@users = FactoryGirl.create_list(:user, 30)
@games = FactoryGirl.create_list(:game, 10)

@users.each do |user|
  5.times do
    FactoryGirl.create(:game_ownership, user: user, game: @games.sample) rescue ActiveRecord::RecordInvalid
  end

  10.times do
    FriendshipInvite.create!(from_user: user, to_user: @users.sample).accept! rescue ActiveRecord::RecordInvalid
  end
end

5.times do
  FactoryGirl.create(:team, founder: @users.sample)
end
