# hi

require 'pp'

require './foo/foo'
require 'thread'
require_relative 'foo/foo'

def foo
  require './foo/foo2'
end

require 'pp'
require 'the-end'

puts 'main.rb'
