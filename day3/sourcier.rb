#!/usr/bin/env ruby


def part1(file)
  lines = File.readlines(file)
  sources = []
  lines.each_with_index do |line, index|
    line_nbs = line.scan /\d+/
    line_nbs.each do |nb|
      x_start = line.index(nb) - 1
      x_start = 0 if x_start.negative?
      x_end = x_start + nb.size + (x_start.zero? ? 0 : 1)
      x_end -= 1 if x_end > line.size - 1
      y_start = (index - 1).negative? ? 0 : index - 1
      y_end = index + 1 > lines.size - 1 ? index : index + 1
      adjacent = lines[y_start..y_end].any? do |x_lines|
        diff = x_lines[x_start..x_end].scan(/[^.\d\s]/)
        !diff.empty?
      end
      sources << nb.to_i if adjacent
    end
  end
  sources.sum
end

puts "part 1 example answer : #{part1('ex_input')}"
puts "part 1 puzzle answer : #{part1('puzzle_input')}"
