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

      str_field = field.cells.reverse.map do |row|
        row.map do |i|
          if i.nil?
            "-"
          elsif i == robot
            DIRECTION_SIGNS[robot.readable_direction]
          else
            "X"
          end
        end.join(" ")
      end.join("\n")

      puts str_field
    end
  end
end
