
locals = Local.order(:created_at).take(6)
50.times do
  title = 'サンプル投稿です！'
  content = 'サンプル用の投稿です。各地域の最新の情報や地元での生活の様子などをお伝えしていきます！'
  locals.each { |local| local.articles.create(title: title, content: content) }
end

intro = '地域の紹介文です。こちらでは地域の特徴や魅力などをお伝えします！'
catchphrase = '地域のキャッチコピーです！'
locals.each { |local| local.create_profile!(introduction: intro, catchphrase: catchphrase,
                                            population: 100000, temperature: 15, moved_in: 10,
                                            waiting_children: 0, land_price: 1000000,
                                            income: 4000000, crime_rate: 0)}


user = User.first
locals = Local.all
bkmks = locals[1..5]
bkmks.each { |bkmk| user.bookmark_local(bkmk) }


