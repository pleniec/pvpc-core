FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@mail.com" }
    password 'password'
    sequence(:nickname) { |n| "user#{n}" }
  end

  factory :game do
    sequence(:name) { |n| "game#{n}" }
    icon 'icon'
    image 'image'
  end
end
