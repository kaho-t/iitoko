FactoryBot.define do
  factory :tag do
    sea { true }
    mountain { true }
    river { true }
    field { true }
    hotspring { true }
    north { true }
    south { true }
    easy_to_go { true }
    small_city { true }
    car { true }
    train { true }
    low_price { true }
    moving_support { true }
    entrepreneur_support { true }
    child_care_support { true }
    job_change_support { true }
    park { true }
    education { true }
    food { true }
    architecture { true }
    history { true }
    event { true }
    tourism { true }
    association :local
  end
end
