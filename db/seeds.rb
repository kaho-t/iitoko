password = ENV['SAMPLE_PASSWORD']

user = User.new(name: "Test Taro",
            email: "#{ENV['SAMPLE_EMAIL']}@example.com",
            password: password,
            password_confirmation: password)
user.skip_confirmation!
user.save!

47.times do |n|
  pref = JpPrefecture::Prefecture.find(n+1)
  name = "#{JpPrefecturesTools::prefecture_name_to_city_name(pref.name)}市"
  email = "#{ENV['SAMPLE_EMAIL']}#{n+1}@example.com"
  local = Local.new(prefecture_code: n+1,
                    email: email,
                    name: name,
                    password: password,
                    password_confirmation: password)
  local.skip_confirmation!
  local.save!
  score = (0..5).to_a
  local.create_score!(nature: score.sample, accessibility: score.sample,
                      budget: score.sample, job_support: score.sample,
                      family_support: score.sample, culture: score.sample)
end


locals = Local.all
catchphrase = '程よく田舎で程よく都会。少し行けば自然が溢れる環境で、ワークライフバランスを充実させませんか？'
locals.each { |local| local.create_profile!(introduction: '#{local.name}は#{local.prefecture.name}の経済・文化の中心地です。医療施設や商業施設も充実しており、生活に必要なものが揃っています。車で少し行けば豊かな自然が広がっているので、ワークライフバランスを充実させたい方におすすめです。', 
                                            catchphrase: catchphrase,
                                            population: 100000, temperature: 15, moved_in: 10,
                                            waiting_children: 0, land_price: 100000,
                                            income: 4000000, crime_rate: 0)}


locals = Local.order(:created_at).take(6)
titles = ['オンライン移住説明会を開催します！', '町のおすすめスポット紹介！', '先輩移住者インタビュー！']
50.times do
  content = '<div class="trix-content"><div>こんにちは！<br>移住を検討中の方に大ニュースです。<br>0月0日にオンライン移住説明会の開催が決定しました！<br><br>
            町のおすすめスポット・暮らしの様子のご紹介や先輩移住者のインタビュー、移住先を選ぶポイントや
            チェックすべき移住支援制度など、盛りだくさんでお伝えします！（こちらはサンプル用の投稿です）</div></div>'
  locals.each { |local| local.articles.create(title: titles.sample(1), content: content) }
end

taggedlocals = Local.order(:created_at).take(20)
taggedlocals.each { |local| local.create_tag!(mountain: true, river: true, field: true, hotspring: true,
                    easy_to_go: true, small_city: true, car: true, train: true,
                    child_care_support: true, park: true, education: true, food: true, architecture: true,
                    history: true, event: true, tourism: true)}

user = User.first
locals = Local.all
bkmks = locals[0..5]
bkmks.each { |bkmk| user.bookmark_local(bkmk) }


