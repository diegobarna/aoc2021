# frozen_string_literal: true

class Navigation
  def initialize(input)
    @planned_course = if input.is_a?(String)
      File.read(input).split("\n")
    else
      input
    end
  end

  def destination
    @planned_course.reduce([0, 0]) do |destination, command|
      direction, distance = command.split(' ')

      vector = case direction
               when "forward"
                 [distance.to_i, 0]
               when "down"
                 [0, distance.to_i]
               when "up"
                 [0, -distance.to_i]
               end

      destination.zip(vector).map(&:sum)
    end
  end

  def destination_with_aim
    aim = 0

    @planned_course.reduce([0, 0]) do |destination, command|
      direction, amount = command.split(' ')

      case direction
      when "forward"
        step = [amount.to_i, (aim * amount.to_i)]
      when "down"
        step = [0, 0]
        aim += amount.to_i
      when "up"
        step = [0, 0]
        aim -= amount.to_i
      end

      destination.zip(step).map(&:sum)
    end
  end

  def destination_product
    destination.reduce(&:*)
  end

  def destination_with_aim_product
    destination_with_aim.reduce(&:*)
  end
end

navigation = Navigation.new("day02.txt")
puts navigation.destination_product
puts navigation.destination_with_aim_product
