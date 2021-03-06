# frozen_string_literal: true

# Blog
module Blog
  autoload :Entry, 'blog/entry'
  autoload :Files, 'blog/files'
  autoload :Git, 'blog/git'
  autoload :Logging, 'blog/logging'
  autoload :Math, 'blog/math'
  autoload :Shell, 'blog/shell'
  autoload :Site, 'blog/site'
  autoload :Social, 'blog/social'
  autoload :Time, 'blog/time'

  # Eager Loads
  require 'blog/commands'
  require 'blog/filters'
  require 'blog/generators'
end
