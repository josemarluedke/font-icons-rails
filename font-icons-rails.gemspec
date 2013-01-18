$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "font-icons-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "font-icons-rails"
  s.version     = FontIconsRails::VERSION
  s.authors     = ["Zbigniew Zemla"]
  s.email       = ["zbyszek@shorelabs.com"]
  s.homepage    = "http://www.shorelabs.com"
  s.summary     = "A package of free font icons for use in Rails apps"
  s.description = "A package of free font icons for use in Rails apps"

  s.files = Dir["{lib,vendor}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = []

  s.add_runtime_dependency 'railties', '>= 3.1.1'
  s.add_runtime_dependency 'sass-rails', '>= 3.1.1'
end
