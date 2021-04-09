FactoryBot.define do
  factory :user do
    name { 'iitoko taro' }
    email { 'iitoko@example.com' }
    password { 'Iitoko123' }
    password_confirmation { 'Iitoko123' }
  end
end
