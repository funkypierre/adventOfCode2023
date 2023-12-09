#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)
  times, distances = lines.map { |line| line.scan(/\d+/).map(&:to_i) }

  wins = []
  times.each_with_index do |time, index|
    record = distances[index]
    wins << (1..time - 1).to_a.filter do |hold|
      (hold * (time - hold)) > record
    end.size
  end
  wins.inject(&:*)
end

def part2(file)
  lines = File.readlines(file)
  time, distance = lines.map { |line| line.scan(/\d+/).join('').to_i }

  wins = []
  wins << (1..time - 1).to_a.filter do |hold|
    (hold * (time - hold)) > distance
  end.size
  wins.inject(&:*)
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
