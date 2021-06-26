FactoryBot.define do
  factory :message do
    association :talkroom
    sent_from { 1 }
    is_user { true }
    content { "MyText" }
    category { "MyString" }
  end
end
