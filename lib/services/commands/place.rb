# frozen_string_literal: true

require_relative "../../operation"
require_relative "../validators/coordinates_validator"
require_relative "../validators/direction_validator"

module Commands
  class Place < Operation

    def call(table:, robot:, command_args:)
      x = command_args[0]&.to_i
      y = command_args[1]&.to_i
      direction = command_args[2]

      Validators::CoordinatesValidator.call(x: x, y: y, table: table)
      Validators::DirectionValidator.call(direction: direction)

      if table.contains?(robot)
        table.move_item(
          from_x: robot.x,
          from_y: robot.y,
          to_x: x,
          to_y: y,
        )
      else
        table.place(item: robot, x: x, y: y)
      end

      robot.update_direction(direction)
      robot.update_coordinates(x, y)
    end

  end
end
