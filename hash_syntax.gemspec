# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_syntax/version'

Gem::Specification.new do |spec|
  spec.name          = "hash_syntax"
  spec.version       = HashSyntax::Version::STRING
  spec.authors       = ["Michael Edgar"]
  spec.email         = ["michael.j.edgar@dartmouth.edu"]
  spec.description   = %q{The new label style for Ruby 1.9's literal hash keys
is somewhat controversial. This tool seamlessly converts Ruby files between
the old and the new syntaxes.}
  spec.summary       = %q{Converts Ruby files to and from Ruby 1.9's Hash syntax}
  spec.homepage      = "http://github.com/michaeledgar/hash_syntax"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 2.3.0'
  spec.add_development_dependency 'yard', '>= 0'

  spec.add_dependency 'object_regex', '~> 1.0.1'
  spec.add_dependency 'trollop', '~> 1.16.2'
end
