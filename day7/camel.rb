#!/usr/bin/env ruby

def five_of_a_kind(cards)
  cards.uniq.size == 1
end

def cards_by_count(cards)
  cards.group_by(&:itself).map { |k,v| [k, v.length] }.to_h
end

def four_of_a_kind(cards)
  cards_by_count(cards).value?(4)
end

def full_house(cards)
  hand = cards_by_count(cards)
  hand.value?(3) && hand.value?(2)
end

def three_of_a_kind(cards)
  hand = cards_by_count(cards)
  hand.value?(3) && hand.values.filter { |x| x == 1 }.size == 2
end

def two_pair(cards)
  hand = cards_by_count(cards)
  hand.values.filter { |x| x == 2 }.size == 2
end

def one_pair(cards)
  hand = cards_by_count(cards)
  hand.values.filter { |x| x == 2 }.size == 1 && hand.values.filter { |x| x == 1 }.size == 3
end

def high_card(cards)
  cards.uniq.size == 5
end

CARDS_POWER = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze
CARDS_POWER_PART_2 = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

def part1(file)
  lines = File.readlines(file)

  types = %w[high_card one_pair two_pair three_of_a_kind full_house four_of_a_kind five_of_a_kind]
  type_methods = types.map { |type| method(type.to_sym) }
  sorted_plays = types.to_h { |type| [type, []] }
  plays = lines.map { |line| line.split(' ') }
  plays.each do |play|
    hand = play.first
    hand_type = type_methods.index { |method| method.call(hand.split('')) }
    sorted_plays[types[hand_type]] << play
  end
  ranked_plays = []
  sorted_plays.each_pair do |type, plays|
    next if plays.empty?

    if plays.size == 1
      ranked_plays.concat plays
    else
      tmp = plays.sort do |a, b|
        hand_a = a.first.split('')
        hand_b = b.first.split('')
        compare_value = 0
        hand_a.each_with_index do |card_a, index|
          power_a = CARDS_POWER.index(card_a)
          power_b = CARDS_POWER.index(hand_b[index])
          next if power_a == power_b

          compare_value = power_a <=> power_b
          break
        end
        compare_value
      end
      ranked_plays.concat tmp
    end
  end
  ranked_plays.each_with_index.map { |play, index| play.last.to_i * (index + 1) }.sum
end

def part2(file)
  lines = File.readlines(file)

  types = %w[high_card one_pair two_pair three_of_a_kind full_house four_of_a_kind five_of_a_kind]
  type_methods = types.map { |type| method(type.to_sym) }
  sorted_plays = types.to_h { |type| [type, []] }
  plays = lines.map { |line| line.split(' ') }
  plays.each do |play|
    hand = play.first
    if hand.include?('J') && !hand.gsub('J', '').empty?
      score = cards_by_count(hand.gsub('J', '').split(''))
      max_letter = score.max_by{|k,v| v}.first
      hand = hand.gsub('J', max_letter)
    end
    hand_type = type_methods.index { |method| method.call(hand.split('')) }
    sorted_plays[types[hand_type]] << play
  end
  ranked_plays = []
  sorted_plays.each_pair do |type, plays|
    next if plays.empty?

    if plays.size == 1
      ranked_plays.concat plays
    else
      tmp = plays.sort do |a, b|
        hand_a = a.first.split('')
        hand_b = b.first.split('')
        compare_value = 0
        hand_a.each_with_index do |card_a, index|
          power_a = CARDS_POWER_PART_2.index(card_a)
          power_b = CARDS_POWER_PART_2.index(hand_b[index])
          next if power_a == power_b

          compare_value = power_a <=> power_b
          break
        end
        compare_value
      end
      ranked_plays.concat tmp
    end
  end
  ranked_plays.each_with_index.map { |play, index| play.last.to_i * (index + 1) }.sum
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
