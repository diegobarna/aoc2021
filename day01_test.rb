require "minitest/autorun"
require "./day01.rb"

class TestDepth < Minitest::Test
  def setup
    input = %i[199 200 208 210 200 207 240 269 260 263]
    @depth = Depth.new(input)
  end

  def test_count_increases
    assert_equal 7, @depth.count_increases
  end
end
