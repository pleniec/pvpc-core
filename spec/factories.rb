FactoryGirl.define do  factory :admin do
    
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@mail.com" }
    password 'password123'
    sequence(:nickname) { |n| "user#{n}" }
  end

  factory :game do
    sequence(:name) { |n| "game#{n}" }

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

  factory :game_ownership do
    sequence(:nickname) { |n| "nickname#{n}" }
  end

  factory :team do
    sequence(:name) { |n| "name#{n}" }
    sequence(:description) { |n| "description#{n}" }
    sequence(:tag) { |n| "TG#{n}" }
  end
end
