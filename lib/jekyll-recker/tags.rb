# frozen_string_literal: true

module Jekyll
  module Recker
    module Tags
      # Version
      class Version < Liquid::Tag
        def render(_context)
          VERSION
        end
      end
    end
  end
end

Liquid::Template.register_tag('recker_version', Jekyll::Recker::Tags::Version)