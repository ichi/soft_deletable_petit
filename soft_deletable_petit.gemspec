# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soft_deletable_petit/version'

Gem::Specification.new do |spec|
  spec.name          = "soft_deletable_petit"
  spec.version       = SoftDeletablePetit::VERSION
  spec.authors       = ["ichi"]
  spec.email         = ["ichi.ttht.1@gmail.com"]

  spec.summary       = %q{Soft Deletable for ActiveRecord.}
  spec.description   = %q{Soft Deletable for ActiveRecord.}
  spec.homepage      = "https://github.com/ichi/soft_deletable_petit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 4.2"
  spec.add_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
end
