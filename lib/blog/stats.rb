# frozen_literal_string: true

require 'date'
require 'json'

module Blog
  # Stats
  module Stats
    def self.logger
      @logger ||= Blog::Log.logger
    end

    def self.write_stats!(journal, path)
      logger.info 'gathering stats'
      stats = gather_stats(journal)

      logger.info "writing stats to #{path.pretty_path}"
      File.open(path, 'w+') do |f|
        f.write(JSON.pretty_generate(stats))
      end
    end

    def self.gather_stats(journal)
      stats = {}
      BaseCruncher.descendants.each do |cruncher_class|
        cruncher = cruncher_class.new(journal)
        stats[cruncher.stats_key] = cruncher.crunch
      end
      stats
    end

    # Base Cruncher
    class BaseCruncher
      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end

      def initialize(journal)
        @journal = journal
        @logger = Blog::Log.logger
      end

      private

      attr_reader :journal

      def average(numlist)
        calc = numlist.inject { |sum, el| sum + el }.to_f / numlist.size
        calc.round
      end

      def total(numlist)
        numlist.inject(0) { |sum, x| sum + x }
      end

      def private_entries
        journal.private_entries
      end

      def public_entries
        journal.public_entries
      end

      def all_entries
        journal.all_entries
      end
    end

    # PostCountCruncher
    class PostCountCruncher < BaseCruncher
      def stats_key
        'posts'
      end

      def crunch
        @logger.debug 'calculating post count'
        {
          public: public_entries.count.pretty,
          private: private_entries.count.pretty,
          all: all_entries.count.pretty
        }
      end
    end

    # WordCountCruncher
    class WordCountCruncher < BaseCruncher
      def stats_key
        'words'
      end

      def crunch
        @logger.debug 'calculating word count'
        {
          public: {
            average: average(public_wordcounts).pretty,
            total: total(public_wordcounts).pretty
          },
          private: {
            average: average(private_wordcounts).pretty,
            total: total(private_wordcounts).pretty
          },
          all: {
            average: average(total_wordcounts).pretty,
            total: total(total_wordcounts).pretty
          }
        }
      end

      private

      def total_wordcounts(entries = nil)
        entries ||= all_entries
        entries.collect(&:body_text).map(&:word_count)
      end

      def private_wordcounts
        total_wordcounts(private_entries)
      end

      def public_wordcounts
        total_wordcounts(public_entries)
      end
    end
  end
end
