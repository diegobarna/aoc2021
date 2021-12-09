# frozen_string_literal: true

class Vents
  def initialize(file)
    @lines = File.read(file).split("\n").map { |line| Line.new(line) }
    @map = {}
  end

  def overlaped_points_count
    @lines.each do |line|
      if line.vertical?
        line.y_range.each do |y|
          add_point_to_map(line.x1, y)
        end
      elsif line.horizontal?
        line.x_range.each do |x|
          add_point_to_map(x, line.y1)
        end
      else
        line.xy_range.each do |x, y|
          add_point_to_map(x, y)
        end
      end
    end

    @map.values.count { |v| v >= 2 }
  end

private

  def key(x, y)
    "#{x},#{y}"
  end

  def add_point_to_map(x, y)
    @map[key(x, y)] ||= 0
    @map[key(x, y)] += 1
  end

  class Line
    def initialize(line)
      @line = line.split(' -> ').map { |point| point.split(',').map(&:to_i) }
    end

    def x1
      @line.dig(0, 0)
    end

    def y1
      @line.dig(0, 1)
    end

    def x2
      @line.dig(1, 0)
    end

    def y2
      @line.dig(1, 1)
    end

    def vertical?
      x1 == x2
    end

    def horizontal?
      y1 == y2
    end

    def x_range
      if x1 > x2
        x1.downto(x2)
      else
        x1..x2
      end.to_a
    end

    def y_range
      if y1 > y2
        y1.downto(y2)
      else
        y1..y2
      end.to_a
    end

    def xy_range
      x_range.zip(y_range)
    end
  end
end

puts Vents.new('day05_test_input').overlaped_points_count;
puts Vents.new('day05.txt').overlaped_points_count;
