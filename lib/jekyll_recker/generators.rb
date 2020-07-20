# frozen_string_literal: true

require 'bundler'
require 'fastimage'
require 'gruff'
require 'mini_magick'

module JekyllRecker
  module Generators
    # Image Resize Generator
    class ImageResize < Jekyll::Generator
      include Mixins::Logging

      def generate(site)
        @site = site
        logger.info 'checking images'
        resizeable_images.each do |f, d|
          logger.info "resizing #{f} to fit #{d}"
          image = MiniMagick::Image.new(f)
          image.resize d
        end
      end

      def image?(file)
        ['.jpg', 'jpeg', '.png', '.svg'].include? File.extname(file)
      end

      def too_big?(width, height)
        width > 800 || height > 800
      end

      def graph?(file)
        file.include?('/graphs/')
      end

      def images
        @site.static_files.collect(&:path).select { |f| image?(f) }
      end

      def resizeable_images
        without_graphs = images.reject { |i| graph?(i) }
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

    # Stats Module
    #
    # Functions for stats generators.
    # @abstract
    module Stats
      include Mixins::Logging
      include Jekyll::Filters

      def key
        self.class.const_get(:KEY)
      end

      def generate(site)
        @site = site
        logger.info "crunching stats.#{key}"
        @site.data['stats'] ||= {}
        @site.data['stats'][key] = crunch
      end

      def crunch
        raise NotImplementedError, '#crunch not implemented!'
      end

      # Calculates the average of a list of numbers.
      #
      # @param [Array<Numeric>] numlist list of numbers to be averaged.
      # @return [Numeric] rounded, calculated average of numlist.
      def average(numlist)
        calc = numlist.inject { |sum, el| sum + el }.to_f / numlist.size
        calc.round
      end

      # Calculates the total of a list of numbers.
      #
      # @param [Array<Numeric>] numlist list of numbers to be totaled.
      # @return [Numeric] calculated total of numlist.
      def total(numlist)
        numlist.inject(0) { |sum, x| sum + x }
      end

      def entries
        @site.posts.docs.select(&:published?).sort_by(&:date).reverse
      end
    end

    # Graphs Module
    #
    # Functions for graph creation.
    # @abstract
    module Graphs
      include Mixins::Logging

      def new_line_graph
        g = Gruff::Line.new
        g.theme = {
          colors: %w[grey black],
          marker_color: 'black',
          font_color: 'black',
          background_colors: 'white'
        }
        g.hide_legend = true
        g
      end

      def graphs_join(path)
        recker = @site.config.fetch('recker', {})
        graphs_dir = recker.fetch('graphs', 'assets/images/graphs/')
        File.join Bundler.root, graphs_dir, path
      end
    end

    # Post Count Generator
    class PostCount < Jekyll::Generator
      include Stats

      KEY = 'posts'

      def crunch
        entries.count
      end
    end

    # Word Count Generator
    class Words < Jekyll::Generator
      include Stats
      include Graphs

      KEY = 'words'

      def crunch
        total_counts = entries.collect(&:content).map { |c| number_of_words(c) }
        make_graph(entries[0..6])
        {
          'average' => average(total_counts),
          'total' => total(total_counts)
        }
      end

      def make_graph(posts)
        g = new_line_graph
        g.labels = Hash[posts.each_with_index.map { |p, i| [i, p.date.strftime("%a")] }]
        g.data :words, posts.collect(&:content).map { |c| number_of_words(c) }.reverse
        g.title = 'Wordcount Over a Week'
        g.x_axis_label = 'Day'
        g.y_axis_label = 'Wordcount'
        g.minimum_value = 0
        g.write(graphs_join('words.png'))
      end
    end

    # Streak Count Generator
    class Streaks < Jekyll::Generator
      include Stats

      KEY = 'days'

      def crunch
        streaks.take(1).map do |count, dates|
          {
            'days' => count,
            'start' => dates[0],
            'end' => dates[1]
          }
        end.first
      end

      private

      def streaks
        _streaks = []
        entry_dates.slice_when do |prev, curr|
          curr != prev - 1
        end.each do |dates|
          first, last = dates.minmax
          _streaks << [(last - first).to_i, [first, last]]
        end
        _streaks
      end

      def entry_dates
        entries.collect(&:date).map { |t| Date.new(t.year, t.month, t.day) }.sort.reverse
      end
    end

    # Swear Count Generator
    class Swears < Jekyll::Generator
      include Stats

      KEY = 'swears'

      def crunch
        results = Hash.new(0)
        entries.collect(&:content).map(&:split).each do |words|
          words = words.map(&:downcase)
          swears.each do |swear|
            count = words.count(swear)
            results[swear] += count
          end
        end
        results.reject { |_k, v| v.zero? }.sort_by { |_k, v| -v }
      end

      private

      def swears
        [
          'ass',
          'asshole',
          'booger',
          'crap',
          'damn',
          'fart',
          'fuck',
          'hell',
          'jackass',
          'piss',
          'poop',
          'shit',
        ]
      end
    end

    # Memory Size Generator
    class Memory < Jekyll::Generator
      include Stats

      KEY = 'memory'

      def crunch
        results = Hash.new(0)
        entries.each do |entry|
          results['chars'] += entry.content.size
          results['spaces'] += entry.content.count(' ')
          results['size'] += entry.content.bytes.to_a.length
        end
        results['size'] = bytes_to_megabytes(results['size'])
        results
      end

      private

      def bytes_to_megabytes(bytes)
        (bytes / (1024.0 * 1024.0)).to_f.round(4)
      end
    end
  end
end
