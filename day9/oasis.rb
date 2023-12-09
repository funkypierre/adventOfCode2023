#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)

  values = []
  lines.each do |line|
    numbers = [line.scan(/-*\d+/).map(&:to_i)]
    until numbers.last.all? 0
      numbers << numbers.last.each_cons(2).map { |a, b| b - a }
    end
    numbers = numbers.reverse
    numbers.each_with_index do |nb, index|
      if index == 0
        nb << 0
      else
        nb << nb.last + numbers[index - 1].last
      end
    end
    values << numbers.last.last
  end
  values.sum
end

def part2(file)
  lines = File.readlines(file)

  values = []
  lines.each do |line|
    numbers = [line.scan(/-*\d+/).map(&:to_i).reverse]
    until numbers.last.all? 0
      numbers << numbers.last.each_cons(2).map { |a, b| b - a }
    end
    numbers = numbers.reverse
    numbers.each_with_index do |nb, index|
      if index == 0
        nb << 0
      else
        nb << nb.last + numbers[index - 1].last
      end
    end
    values << numbers.last.last
  end
  values.sum
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
