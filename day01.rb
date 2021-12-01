# frozen_string_literal: true

class Depth
  def initialize(input)
    @depths = if input.is_a?(String)
                File.read(input).split("\n").map(&:to_i)
              else
                input
              end
  end

  def count_increases(window = 1)
    @depths.each_cons(window)
           .map(&:sum)
           .each_cons(2)
           .count do |first, second|
             first < second
           end
  end
end

puts "Part 1: " + Depth.new("day01.txt").count_increases.to_s
puts "Part 2: " + Depth.new("day01.txt").count_increases(3).to_s
