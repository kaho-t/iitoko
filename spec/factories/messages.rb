FactoryBot.define do
  factory :message do
    association :talkroom
    sender { 1 }
    sender_type { 'User' }
    content { 'MyText' }
    category { 'MyString' }
  end
end
