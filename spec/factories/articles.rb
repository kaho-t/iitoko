FactoryBot.define do
  factory :article do
    title { "MyString" }
    content { "this is my article!" }
    association :local
    trait :with_attachment do
      attachment { File.new("#{Rails.root}/spec/files/attachment.jpeg")}
    end
  end
end
