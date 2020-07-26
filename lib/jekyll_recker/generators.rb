# frozen_string_literal: true

module JekyllRecker
  # Generators Module
  module Generators
    # Base Generator
    module Base
      include Date
      include Logging
      include Math
    end

    # Stats Generator
    class Stats < Jekyll::Generator
      include Base

      attr_reader :site

      def generate(site)
        @site = Site.new(site)
        generate_stats!
        if @site.production?
          info 'production detected. skipping graphs'
        else
          info 'generating graphs'
          Graphs.generate_graphs(@site)
        end
      end

      def generate_stats!
        info 'calculating statistics'
        site.data['stats'] = {
          'total_words' => total(site.word_counts),
          'average_words' => average(site.word_counts),
          'total_posts' => site.entries.size,
          'consecutive_posts' => calculate_streaks(site.dates).first['days'],
          'swears' => calculate_swears,
        }
      end

      private

      def calculate_swears
        results = Hash[count_swears]
        results['total'] = total(results.values)
        results
      end

      def count_swears
        occurences(swears, site.words).reject { |_k, v| v.zero? }.sort_by { |_k, v| -v }
      end

      def swears
        %w[
          ass
          asshole
          booger
          crap
          damn
          fart
          fuck
          hell
          jackass
          piss
          poop
          shit
        ]
      end
    end

    # Image Resize Generator
    class ImageResize < Jekyll::Generator
      include Base

      attr_reader :site

      def generate(site)
        @site = Site.new(site)

        if @site.production?
          info 'production detected, skipping images'
          return
        end

        load_deps!

        info 'checking images'
        resizeable_images.each do |f, d|
          info "resizing #{f} to fit #{d}"
          image = MiniMagick::Image.new(f)
          image.resize d
        end
      end

      def too_big?(width, height)
        width > 800 || height > 800
      end

      def load_deps!
        require 'fastimage'
        require 'mini_magick'
      end

      def graph?(file)
        file.include?('/graphs/')
      end

      def resizeable_images
        without_graphs = site.images.reject { |i| graph?(i) }
        with_sizes = without_graphs.map { |f| [f, FastImage.size(f)].flatten }
        with_sizes.select! { |f| too_big?(f[1], f[2]) }
        with_sizes.map do |f, w, h|
          dimensions = if w > h
                         '800x600'
                       else
                         '600x800'
                       end
          [f, dimensions]
        end
      end
    end
  end
end
