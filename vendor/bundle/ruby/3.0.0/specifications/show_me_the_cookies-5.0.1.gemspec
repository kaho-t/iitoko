# -*- encoding: utf-8 -*-
# stub: show_me_the_cookies 5.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "show_me_the_cookies".freeze
  s.version = "5.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nicholas Rutherford".freeze]
  s.date = "2020-05-12"
  s.description = "Cookie manipulation for Capybara drivers -- viewing, deleting, ...".freeze
  s.email = ["nick.rutherford@gmail.com".freeze]
  s.homepage = "https://github.com/nruth/show_me_the_cookies".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Cookie manipulation for Capybara drivers".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capybara>.freeze, [">= 2", "< 4"])
  else
    s.add_dependency(%q<capybara>.freeze, [">= 2", "< 4"])
  end
end
