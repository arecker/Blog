# frozen_string_literal: true

require 'bundler'
require 'json'
require 'simplecov'

def root
  File.expand_path('..', __dir__)
end

class JekyllDataReporter
  def format(result)
    json = JSON.pretty_generate(data(result))

    File.open(output_filepath, 'w+') do |file|
      file.puts json
    end

    json
  end

  def data(result)
    {
      metrics: {
        covered_percent: result.covered_percent,
        covered_strength: result.covered_strength.nan? ? 0.0 : result.covered_strength,
        covered_lines: result.covered_lines,
        total_lines: result.total_lines
      }
    }
  end

  def output_filepath
    File.join(root, '_site/coverage/data.json')
  end
end

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    JekyllDataReporter
  ]
)

SimpleCov.start do
  coverage_dir File.join(root, '_site/coverage')
end

require 'blog'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
