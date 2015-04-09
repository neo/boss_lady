$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "boss_lady/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "boss_lady"
  s.version     = BossLady::VERSION
  s.authors     = ["Björn Andersson <bjorn@neo.com>", "Divya Bhargov <divya.bhargov@neo.com>"]
  s.email       = ["pairing@neo.com"]
  s.homepage    = "http://github.com/neo/boss_lady"
  s.summary     = "Make it easier to manage your factory girls"
  s.description = "A GUI for FactoryGirl"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.13"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl_rails'
end
