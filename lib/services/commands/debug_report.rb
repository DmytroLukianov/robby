require "amazing_print"
require_relative "../../operation"

DIRECTION_SIGNS = {
  "EAST" => "→",
  "NORTH" => "↑",
  "WEST" => "←",
  "SOUTH" => "↓",
}.freeze

module Commands
  class DebugReport < Operation
    def call(field:, robot:)
      puts "Position: #{robot.x},#{robot.y},#{robot.readable_direction}, #{robot.direction}°"

      str_field = field.cells.reverse.map.with_index do |row, ix|
        row.map.with_index do |i, jx|
          if i.nil?
            "#{ix}-#{jx}"
          elsif i == robot
            "o#{DIRECTION_SIGNS[robot.readable_direction]}o"
          else
            "X"
          end
        end.join(" ")
      end.join("\n")

      puts str_field
    end
  end
end
