FactoryBot.define do
  factory :local do
    name { '東京都北区' }
    sequence(:email) { |n| "local#{n}@example.com" }
    password { 'Iitoko123' }
    password_confirmation { 'Iitoko123' }
  end
end
