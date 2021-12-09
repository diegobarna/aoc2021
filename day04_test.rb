require "minitest/autorun"
require "./day04.rb"

class TestBingo < Minitest::Test
  def setup
    @bingo = Bingo.new("day04_test")
  end

  def test_win
    assert_equal(4512, @bingo.win)
  end

  def test_lose
    assert_equal(1924, @bingo.lose)
  end
end
