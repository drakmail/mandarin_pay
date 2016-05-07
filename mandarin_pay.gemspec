$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mandarin_pay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mandarin_pay"
  s.version     = MandarinPay::VERSION
  s.authors     = ["Alexander Maslov"]
  s.email       = ["drakmail@gmail.com"]
  s.homepage    = "http://github.com/drakmail/mandarin_pay"
  s.summary     = "Ruby wrapper for Mandarin Pay API"
  s.description = "Ruby wrapper for Mandarin Pay API aimed to make Mandarin Pay integration even more easier"
  s.license     = "MIT"

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/mandarin_pay/*`.split("\n")

  s.add_dependency "rails", ">= 4.0.0", "<= 5.1"

  s.add_development_dependency "sqlite3", "~> 1.3", ">= 1.3.0"
  s.add_development_dependency "rspec-rails", "~> 4.3.1", ">= 4.3.0"
end
