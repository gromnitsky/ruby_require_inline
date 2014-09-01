require_relative 'minitest_helper'

require_relative '../lib/ruby_require_inline/depswalk'

class TestDepsWalk < Minitest::Test
  def setup
    @files = []
    dw = RubyRequireInline::DepsWalk.new [], "fixtures/01/main.rb"
    dw.start do |file, level, not_found|
      @files << file
    end

    @files.map {|idx| idx.sub!(/.*fixtures\/01\//, '') }
  end

  def test_smoke
    assert_equal ["main.rb",
                  "pp",
                  "foo/foo.rb",
                  "foo/bar/bar.rb",
                  "../ffffff",
                  "qwerty",
                  "thread",
                  "foo/foo2.rb",
                  "fileutils",
                  "the-end"], @files
  end
end
