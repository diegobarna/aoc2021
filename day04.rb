# frozen_string_literal: true

class Bingo
  def initialize(file)
    input = File.read(file).split("\n\n")
    @numbers = input.shift.split(',').map(&:to_i)
    @cards = input.map { |card| card.split.map(&:to_i) }
  end

  def win
    number = @numbers.shift

    @cards.map! do |card|
      card.map { |n| n == number ? nil : n }
    end

    if winner_cards.any?
      number * winner_cards.first.compact.sum
    else
      win
    end
  end

  def lose
    number = @numbers.shift

    @cards.map! do |card|
      card.map { |n| n == number ? nil : n }
    end

    if @cards.one? && last_winner_card
      number * @cards.flatten.compact.sum
    else
      @cards.reject! { |card| winner_cards.include? card }
      lose
    end
  end

private

  def winner_cards
    @cards.select do |card|
      card.each_slice(5).any?(&:none?) ||
      card.each_slice(5).to_a.transpose.any?(&:none?)
    end
  end

  def last_winner_card
    @cards.reject { |card| winner_cards.include? card }.size.zero?
  end
end

puts Bingo.new("day04.txt").win
puts Bingo.new("day04.txt").lose
