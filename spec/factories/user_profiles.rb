FactoryBot.define do
  factory :user_profile do
    prefecture_code {1}
    age {30}
    proposed_site {'未定'}
    job {'会社員'}
    family_structure {'3人家族'}
    timing {'2,3年以内'}
    content {'在宅勤務をきっかけに地方移住を検討し始めました。'}
    association :user
  end
end
