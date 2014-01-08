# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vinery/version'

Gem::Specification.new do |spec|
  spec.name          = "vinery"
  spec.version       = Vinery::VERSION
  spec.authors       = ["Jake Bellacera"]
  spec.email         = ["jakeb@eleveninc.com"]
  spec.description   = "Ruby interface for Vine."
  spec.summary       = "Ruby interface for Vine."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "0.12.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "dotenv", "0.9.0"
end
