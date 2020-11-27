# frozen_string_literal: true

$LOAD_PATH.unshift(__dir__) unless $LOAD_PATH.include? __dir__

# Blog
module Blog
  autoload :Git, 'blog/git'
  autoload :Logging, 'blog/logging'
  autoload :Math, 'blog/math'
  autoload :Shell, 'blog/shell'
  autoload :Time, 'blog/time'

  # Eager Loads
  require 'blog/generators'
end
