require "minitest/autorun"
require "./day02.rb"

class TestNavigation < Minitest::Test
  def setup
    input = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ]
    @navigation = Navigation.new(input)
  end

  def test_destination
    assert_equal [15, 10], @navigation.destination
  end

  def test_destination_product
    assert_equal 150, @navigation.destination_product
  end

  def test_destination_with_aim
    assert_equal [15, 60], @navigation.destination_with_aim
  end

  def test_destination_with_aim_product
    assert_equal 900, @navigation.destination_with_aim_product
  end
end
