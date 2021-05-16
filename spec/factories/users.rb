FactoryBot.define do
  factory :user do
    name { 'iitoko taro' }
    sequence(:email) { |n| "taro#{n}@example.com" }
    password { 'Iitoko123' }
    password_confirmation { 'Iitoko123' }
  end
end
