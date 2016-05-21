# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eleVAT/version'

Gem::Specification.new do |spec|
  spec.name          = "eleVAT"
  spec.version       = EleVAT::VERSION
  spec.authors       = ["Simone Romanelli"]
  spec.email         = ["simone.romanelli.dev@gmail.com"]

  spec.summary          = "eleVAT"
  spec.description      = "A simple receipts calculator."
  spec.license          = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug"
end
