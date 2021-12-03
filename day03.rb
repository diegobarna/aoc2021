# frozen_string_literal: true

class Diagnostic
  def initialize(input)
    @report = if input.is_a?(String)
      File.read(input).split("\n")
    else
      input
    end
  end

  def power_consumption
    gamma_rate * epsilon_rate
  end

  def life_support_rating
    oxygen_generator_rating = filter_by(:most_common, @report)
    co2_scrubber_rating = filter_by(:least_common, @report)

    oxygen_generator_rating * co2_scrubber_rating
  end

private

  def gamma_rate
    (0...@report.first.length).map do |index|
      (sum_digits_at_index(@report, index) > (@report.length / 2) ? "1" : "0")
    end.join.to_i(2)
  end

  def sum_digits_at_index(list, index)
    list.sum { |line| line[index].to_i }
  end

  def epsilon_rate
    (0...@report.first.length).map do |index|
      (sum_digits_at_index(@report, index) < (@report.length / 2) ? "1" : "0")
    end.join.to_i(2)
  end

  def filter_by(filter_method, list, index = 0)
    bit_criteria = send(filter_method, list, index)
    filtered_list = list.filter { |line| line[index] == bit_criteria }

    if filtered_list.one?
      filtered_list.first.to_i(2)
    else
      filter_by(filter_method, filtered_list, index + 1)
    end
  end

  def most_common(list, index)
    sum_digits_at_index(list, index) >= (list.length / 2.0) ? "1" : "0"
  end

  def least_common(list, index)
    sum_digits_at_index(list, index) < (list.length / 2.0) ? "1" : "0"
  end
end

diagnostic = Diagnostic.new("day03.txt")
puts diagnostic.power_consumption
puts diagnostic.life_support_rating
