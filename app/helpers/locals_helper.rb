module LocalsHelper
  def gravatar_for(local, _options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(local.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: local.name, class: 'gravatar')
  end
end
