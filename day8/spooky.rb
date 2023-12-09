#!/usr/bin/env ruby

def part1(file)
  lines = File.readlines(file)
  directions = { "L": 0, "R": 1 }

  instructions = lines.first.gsub(/\n/, '').split('')
  map = {}
  lines[2..lines.size - 1].each do |line|
    splitted = line.split(' = ')
    current_node = splitted.first
    next_nodes = splitted.last.gsub(/\(|\)|\n/, '').split(', ')
    map[current_node] = next_nodes
  end
  current_node = 'AAA'
  direction_index = 0
  steps = 0
  while current_node != 'ZZZ'
    direction_index = 0 if instructions[direction_index].nil?
    direction = instructions[direction_index]
    current_node = map[current_node][directions[direction.to_sym]]
    steps += 1
    direction_index += 1
  end
  steps
end

def part2(file)
  lines = File.readlines(file)
  directions = { "L": 0, "R": 1 }

  instructions = lines.first.gsub(/\n/, '').split('')
  map = {}
  lines[2..lines.size - 1].each do |line|
    splitted = line.split(' = ')
    current_node = splitted.first
    next_nodes = splitted.last.gsub(/\(|\)|\n/, '').split(', ')
    map[current_node] = next_nodes
  end
  starting_nodes = map.keys.filter { |key| key.chars.last == 'A' }
  scores = []
  starting_nodes.each do |start|
    direction_index = 0
    steps = 0
    current_node = start
    while current_node.chars.last != 'Z'
      direction_index = 0 if instructions[direction_index].nil?
      direction = instructions[direction_index]
      current_node = map[current_node][directions[direction.to_sym]]
      steps += 1
      direction_index += 1
    end
    scores.push steps
  end
  scores.reduce(1, :lcm)
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
puts "part 2 example answer : #{part2('ex2_input')}"
puts "part 2 puzzle answer : #{part2('puzzle_input')}"
