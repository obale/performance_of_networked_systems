# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'performance/version'

Gem::Specification.new do |spec|
  spec.name          = "performance"
  spec.version       = Performance::VERSION
  spec.authors       = ["Alex Oberhauser"]
  spec.email         = ["alex.oberhauser@networld.to"]
  spec.summary       = %q{Performance measurement tool for HTTP requests.}
  spec.description   = %q{This software was developed during the course 'Performance of Networked Systems' (2014) at the VU Amsterdam.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "data_mapper"
  spec.add_dependency "dm-sqlite-adapter"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
end
