# -*- encoding: utf-8 -*-
# stub: database_rewinder 0.9.6 ruby lib

Gem::Specification.new do |s|
  s.name = "database_rewinder".freeze
  s.version = "0.9.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Akira Matsuda".freeze]
  s.date = "2021-05-31"
  s.description = "A minimalist's tiny and ultra-fast database cleaner for Active Record".freeze
  s.email = ["ronnie@dio.jp".freeze]
  s.homepage = "https://github.com/amatsuda/database_rewinder".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.2.25".freeze
  s.summary = "A minimalist's tiny and ultra-fast database cleaner".freeze

  s.installed_by_version = "3.2.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
  end
end
