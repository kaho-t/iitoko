FactoryBot.define do
  factory :profile do
    introduction { 'MyText' }
    population { 1 }
    temperature { 1 }
    moved_in { 1 }
    waiting_children { 1 }
    land_price { 1 }
    income { 1 }
    crime_rate { 1 }
    association :local
  end
end
