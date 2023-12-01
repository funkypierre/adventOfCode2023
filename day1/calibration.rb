#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)
  numbers = []
  lines.each do |line|
    digits = line.gsub(/[^0-9]/, '').split('')
    numbers << (digits.first + digits.last).to_i
  end
  numbers.sum
end

def part2(file)
  lines = File.readlines(file)
  dictionnary = %w[one two three four five six seven eight nine]
  regex = /(?=(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine))/
  numbers = []
  lines.each do |line|
    digits = line.scan(regex).flatten.map { |x| x.to_i != 0 ? x : (dictionnary.index(x) + 1).to_s }
    numbers << (digits.first + digits.last).to_i
  end
  numbers.sum
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex2_input')}"
puts "part 2 puzzle answer : #{part2('puzzle2_input')}"
