20.times do |n|
  localname = "SAMPLE2-#{n+1}市"
  email = "example2-#{n+1}@example.com"
  password = "Password123"
  Local.create!(prefecture_code: 2,
                name: localname,
                email: email,
                password: password,
                password_confirmation: password)
  local = Local.last
  score = (0..5).to_a
  local.create_score!(nature: score.sample, accessibility: score.sample,
                      budget: score.sample, job_support: score.sample,
                      family_support: score.sample, culture: score.sample)
end