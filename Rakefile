require 'rubygems'
require 'rake'

require './lib/hash_syntax/version'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "hash_syntax"
    gem.summary = %Q{Converts Ruby files to and from Ruby 1.9's Hash syntax}
    gem.description = %Q{The new label style for Ruby 1.9's literal hash keys
is somewhat controversial. This tool seamlessly converts Ruby files between
the old and the new syntaxes.}
    gem.email = "michael.j.edgar@dartmouth.edu"
    gem.homepage = "http://github.com/michaeledgar/hash_syntax"
    gem.authors = ["Michael Edgar"]
    gem.add_dependency 'object_regex', '~> 1.0.1'
    gem.add_dependency 'trollop', '~> 1.16.2'
    gem.add_development_dependency 'rspec', '>= 2.3.0'
    gem.add_development_dependency "yard", ">= 0"
    gem.version = HashSyntax::Version::STRING
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
