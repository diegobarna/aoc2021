# frozen_string_literal: true

class Lanternfish
  def initialize(initial_state)
    @state = {}
    9.times.each do |index|
      @state[index] = initial_state.count { |timer| timer == index } || 0
    end
  end

  def run(days = 80)
    days.times do |day|
      new_fishes = 0
      old_fishes = 0

      8.times do |timer|
        if timer.zero?
          new_fishes = @state[timer]
          old_fishes = @state[timer]
        end
        @state[timer] = @state[timer + 1]
      end

      @state[6] += old_fishes
      @state[8] = new_fishes
    end

    @state.values.compact.sum
  end
end

test_initial_state = [3,4,3,1,2]
initial_state = [1,2,1,1,1,1,1,1,2,1,3,1,1,1,1,3,1,1,1,5,1,1,1,4,5,1,1,1,3,4,1,1,1,1,1,1,1,5,1,4,1,1,1,1,1,1,1,5,1,3,1,3,1,1,1,5,1,1,1,1,1,5,4,1,2,4,4,1,1,1,1,1,5,1,1,1,1,1,5,4,3,1,1,1,1,1,1,1,5,1,3,1,4,1,1,3,1,1,1,1,1,1,2,1,4,1,3,1,1,1,1,1,5,1,1,1,2,1,1,1,1,2,1,1,1,1,4,1,3,1,1,1,1,1,1,1,1,5,1,1,4,1,1,1,1,1,3,1,3,3,1,1,1,2,1,1,1,1,1,1,1,1,1,5,1,1,1,1,5,1,1,1,1,2,1,1,1,4,1,1,1,2,3,1,1,1,1,1,1,1,1,2,1,1,1,2,3,1,2,1,1,5,4,1,1,2,1,1,1,3,1,4,1,1,1,1,3,1,2,5,1,1,1,5,1,1,1,1,1,4,1,1,4,1,1,1,2,2,2,2,4,3,1,1,3,1,1,1,1,1,1,2,2,1,1,4,2,1,4,1,1,1,1,1,5,1,1,4,2,1,1,2,5,4,2,1,1,1,1,4,2,3,5,2,1,5,1,3,1,1,5,1,1,4,5,1,1,1,1,4]

puts Lanternfish.new(test_initial_state).run
puts Lanternfish.new(initial_state).run
puts Lanternfish.new(test_initial_state).run(256)
puts Lanternfish.new(initial_state).run(256)
