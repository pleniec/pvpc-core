FactoryGirl.define do
  factory :user, class: Users::User do
    sequence(:email) { |n| "user#{n}@mail.com" }
    password 'password123'
    sequence(:nickname) { |n| "user#{n}" }
  end

  factory :game do
    sequence(:name) { |n| "game#{n}" }
    icon 'icon'
    image 'image'

    after :create do |game|
      create_list(:game_rule, 3, game: game)
    end
  end

  factory :game_rule do
    sequence(:name) { |n| "game_rule#{n}" }

    after :create do |rule|
      create_list(:game_rule_entry, 3, rule: rule)
    end
  end

  factory :game_rule_entry do
    sequence(:key) { |n| "entry_key#{n}" }
    sequence(:value) { |n| "entry_value#{n}" }
  end

  factory :user_game do
    sequence(:nickname) { |n| "nickname#{n}" }
  end
end
