FactoryBot.define do
  factory :user do
    name { 'iitoko taro' }
    email { 'taro@example.com' }
    password { 'Iitoko123' }
    password_confirmation { 'Iitoko123' }
    activated { true }
    activated_at { Time.zone.now }
  end
end
