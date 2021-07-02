FactoryBot.define do
  factory :contact do
    email { "test@example.com" }
    category { "お問い合わせ" }
    content { "全て無料で使えますか？" }
  end
end
