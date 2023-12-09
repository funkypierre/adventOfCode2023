#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)
  points = 0
  lines.each do |line|
    winning, player = line.split(':').last.split('|').map { |s| s.split(' ') }
    matches = (winning & player).size
    next if matches.zero?

    points += (1...matches).inject(1) { |x| x * 2 }
  end
  points
end

def recur(total, scratchcards)
  total += scratchcards.values.flatten.size
  scratchcards.each_pair do |index, cards|
    total = recur(total, scratchcards.select { |key, _| cards.include? key })
  end
  total
end

def part2(file)
  lines = File.readlines(file)
  scratchcards = {}
  total = 0
  lines.each_with_index do |line, index|
    total += 1
    winning, player = line.split(':').last.split('|').map { |s| s.split(' ') }
    next_cards = (winning & player).size
    scratchcards[index] = if next_cards.zero?
                            []
                          else
                            (index + 1..index + next_cards).to_a
                          end
  end
  recur(total, scratchcards)
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
