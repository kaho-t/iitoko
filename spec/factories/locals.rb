FactoryBot.define do
  factory :local do
    prefecture_code { 13 }
    name { '北区' }
    sequence(:email) { |n| "local#{n}@example.com" }
    password { 'Iitoko123' }
    password_confirmation { 'Iitoko123' }
  end
end
