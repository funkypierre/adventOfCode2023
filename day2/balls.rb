#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)
  games = {}
  theory = {
    'red' => 12,
    'green' => 13,
    'blue' => 14
  }
  lines.each_with_index do |line, index|
    line
      .split(':')
      .last
      .split(';')
      .map do |x|
        x.split(',')
         .map { |y| y.split(' ') }
         .each { |z| ((games[index + 1] ||= {})[z.last] ||= []).push z.first.to_i }
      end
  end
  possible_games = games.keep_if do |_, colors|
    theory.all? { |key, value| colors[key].max <= value }
  end
  possible_games.keys.sum
end

def part2(file)
  lines = File.readlines(file)
  games = []
  theory = {
    'red' => 12,
    'green' => 13,
    'blue' => 14
  }
  lines.each_with_index do |line, index|
    line
      .split(':')
      .last
      .split(';')
      .map do |x|
        x.split(',')
         .map { |y| y.split(' ') }
         .each { |z| ((games[index] ||= {})[z.last] ||= []).push z.first.to_i }
      end
  end
  games.map { |game| theory.keys.map { |color| game[color].max }.inject(:*) }.sum
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
