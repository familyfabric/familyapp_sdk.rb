# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "familyapp_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "familyapp_sdk"
  spec.version       = FamilyappSdk::VERSION
  spec.authors       = ["Familyapp API Team"]
  spec.email         = ["lukasz.horonziak@stermedia.eu"]

  spec.summary       = 'Familyapp SDK'
  spec.description   = 'SDK for familyapp channel'
  spec.homepage      = 'http://rubygems.org/gems/familyapp_sdk'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'rest-client', '~> 1.7'
  spec.add_development_dependency 'rails', '~> 4.2'
end
