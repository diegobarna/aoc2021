require "minitest/autorun"
require "./day03.rb"

class TestDiagnostic < Minitest::Test
  def setup
    input = %w[
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    ]
    @diagnostic = Diagnostic.new(input)
  end

  def test_power_consumption
    assert_equal(198, @diagnostic.power_consumption)
  end

  def test_life_support_rating
    assert_equal(230, @diagnostic.life_support_rating)
  end
end
