# -*- encoding: utf-8 -*-
# stub: jp_prefectures_tools 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jp_prefectures_tools".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Takuya Mukohira".freeze]
  s.date = "2014-07-18"
  s.email = ["takuya.mk96@gmail.com".freeze]
  s.homepage = "https://github.com/lo-upe/jp_prefectures_tools".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.25".freeze
  s.summary = "This is a tools of prefectures of Japan.".freeze

  s.installed_by_version = "3.2.25" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
