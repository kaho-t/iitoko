user = User.new(name: "Test Taro",
            email: "test@example.com",
            password: "Password123",
            password_confirmation: "Password123")
user.skip_confirmation!
user.save!

l = Local.new(prefecture_code: 1,
            name: "SAMPLE市",
            email: "test@example.com",
            password: "Password123",
            password_confirmation: "Password123")
l.skip_confirmation!
l.save!

50.times do |n|
  p_code = (1..47).to_a
  localname = "SAMPLE#{n+1}市"
  email = "example-#{n+1}@example.com"
  password = "Password123"
  local = Local.new(prefecture_code: p_code.sample,
                name: localname,
                email: email,
                password: password,
                password_confirmation: password)
  local.skip_confirmation!
  local.save!
  score = (0..5).to_a
  local.create_score!(nature: score.sample, accessibility: score.sample,
                      budget: score.sample, job_support: score.sample,
                      family_support: score.sample, culture: score.sample)
end

20.times do |n|
  localname = "SAMPLE2-#{n+1}市"
  email = "example2-#{n+1}@example.com"
  password = "Password123"
  local = Local.new(prefecture_code: 2,
                name: localname,
                email: email,
                password: password,
                password_confirmation: password)
  local.skip_confirmation!
  local.save!
  score = (0..5).to_a
  local.create_score!(nature: score.sample, accessibility: score.sample,
                      budget: score.sample, job_support: score.sample,
                      family_support: score.sample, culture: score.sample)
end


locals = Local.order(:created_at).take(6)
50.times do
  title = 'サンプル投稿です！'
  content = 'サンプル用の投稿です。各地域の最新の情報や地元での生活の様子などをお伝えしていきます！'
  locals.each { |local| local.articles.create(title: title, content: content) }
end

taggedlocals = Local.order(:created_at).take(20)
 

intro = '地域の紹介文です。こちらでは地域の特徴や魅力などをお伝えします！'
catchphrase = '地域のキャッチコピーです！'
locals.each { |local| local.create_profile!(introduction: intro, catchphrase: catchphrase,
                                            population: 100000, temperature: 15, moved_in: 10,
                                            waiting_children: 0, land_price: 1000000,
                                            income: 4000000, crime_rate: 0)}


user = User.first
locals = Local.all
bkmks = locals[0..5]
bkmks.each { |bkmk| user.bookmark_local(bkmk) }


