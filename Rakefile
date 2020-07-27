# frozen_string_literal: true

begin
  require 'bump/tasks'
rescue LoadError
  puts 'skipping bump/tasks'
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end
