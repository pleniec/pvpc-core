FactoryGirl.define do  factory :team_membership_request do
    
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@mail.com" }
    password 'password123'
    sequence(:nickname) { |n| "user#{n}" }

    factory :user_with_game_ownerships do
      after :create do |user|
        create_list(:game, 3).each do |game|
          create(:game_ownership, user: user, game: game)
        end
      end
    end
  end

  factory :friendship_invite do
    before :create do |friendship_invite|
      friendship_invite.from_user = create(:user) if friendship_invite.from_user_id.nil?
      friendship_invite.to_user = create(:user) if friendship_invite.to_user_id.nil?
    end
  end

  factory :friendship do
    before :create do |friendship|
      friendship.user = create(:user) if friendship.user_id.nil?
      friendship.friend = create(:user) if friendship.friend_id.nil?
    end
    
    after :create do |friendship|
      Friendship.create!(user: friendship.friend, friend: friendship.user)
    end
  end

  factory :game do
    sequence(:name) { |n| "game#{n}" }

    after :create do |game|
      create_list(:game_rule, 3, game: game)
    end
  end

  factory :game_rule do
    sequence(:name) { |n| "game_rule#{n}" }
    sequence(:properties) { |n| {prop1: 'val1', prop2: 'val2'} }
  end

  factory :game_ownership do
    sequence(:nickname) { |n| "nickname#{n}" }
  end

  factory :team do
    sequence(:name) { |n| "name#{n}" }
    sequence(:description) { |n| "description#{n}" }
    sequence(:tag) { |n| "TG#{n}" }
    founder { create(:user) }
  end

  factory :notification do
    user { create(:user) }
    type 'NEW_FRIENDSHIP'
  end
end
