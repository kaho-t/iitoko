FactoryBot.define do
  factory :footprint do
    visitor_id { 1 }
    is_user { false }
    visited_id { 1 }
    to_user { false }
  end
end
