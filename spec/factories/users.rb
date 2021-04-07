FactoryBot.define do
  factory :user do
    name { 'iitoko taro' }
    email { 'iitoko@example.com' }
    password { 'iitoko123' }
    password_confirmation { 'iitoko123' }
  end
end
