FactoryBot.define do
  factory :score do
    nature { 0 }
    accessibility { 0 }
    budget { 0 }
    job_support { 0 }
    family_support { 0 }
    culture { 0 }
    association :user
    association :local
  end
end
