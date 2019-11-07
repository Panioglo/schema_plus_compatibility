# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schema_plus/compatibility/version'

Gem::Specification.new do |gem|
  gem.name          = "schema_plus_compatibility"
  gem.version       = SchemaPlus::Compatibility::VERSION
  gem.authors       = ["ronen barzel", "boaz yaniv"]
  gem.email         = ["ronen@barzel.org", "boazyan@gmail.com"]
  gem.summary       = %q{Compatibility helpers for the SchemaPlus family of gems}
  gem.description   = %q{Compatibility helpers for the SchemaPlus family of gems}
  gem.homepage      = "https://github.com/SchemaPlus/schema_plus_compatibility"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activerecord", ">= 4.2", "<= 6"
  gem.add_dependency "schema_monkey", "~> 2.1"

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "schema_dev", "~> 3.5"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "simplecov-gem-profile"
end
