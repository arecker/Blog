# frozen_string_literal: true

require 'yaml'

module Blog
  # Config
  class Config
    attr_reader :data

    def self.config_path
      File.expand_path('~/.publisher.yml')
    end

    def self.load_from_file
      if File.file? config_path
        Blog.logger.info "loading config from #{config_path.pretty_path}"
        new(YAML.load_file(config_path) || {})
      else
        Blog.logger.error "#{config_path.pretty_path} not found!"
        nil
      end
    end

    def required_keys
      %w[journal_path posts_dir]
    end

    def initialize(data)
      @data = data
    end

    def validate!
      missing = missing_fields

      if missing.any?
        Blog.logger.error "missing configuration: #{missing_fields.to_and_list}"
        false
      else
        Blog.logger.info 'configuration is valid'
        true
      end
    end

    def journal_path
      File.expand_path(@data.fetch('journal_path'))
    end

    def posts_dir
      File.expand_path(@data.fetch('posts_dir'))
    end

    private

    def missing_fields
      required_keys.reject { |k| @data.key? k }
    end
  end
end