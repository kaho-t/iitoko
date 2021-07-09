FactoryBot.define do
  factory :notification do
    notice_to { 1 }
    is_for_user { true }
    notice_from { 1 }
    is_from_user { false }
    action { bookmark }
    bookmark_id { 1 }
    talkroom_id { nil }
    message_id { nil }
    article_id { nil }
    is_checked { false }
    footprint_id { nil }
  end
end
