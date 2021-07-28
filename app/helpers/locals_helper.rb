module LocalsHelper
  def gravatar_for(local, _options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(local.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: local.name, class: 'gravatar')
  end

  def add_units(str)
    # insertは破壊的なメソッドなので元の文字列が変化しないようにコピー
    dup_str = str.dup
    # 後ろから6番目("123456789円"の"5"の後ろに"万"を挿入)
    dup_str.insert(-5, '万') if dup_str.length >= 5
    # 後ろから11番目("12345万6789円"の"1"の後ろに"億"を挿入)
    dup_str.insert(-10, '億') if dup_str.length >= 10
    dup_str
  end
end
