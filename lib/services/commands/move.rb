# frozen_string_literal: true

require_relative "../../operation"
require_relative "../validators/coordinates_validator"

module Commands
  class Move < Operation

    def call(table:, robot:, command_args: nil)
      Validators::CoordinatesValidator.call(x: robot.next_x, y: robot.next_y, table: table)

      table.move_item(
        from_x: robot.x,
        from_y: robot.y,
        to_x: robot.next_x,
        to_y: robot.next_y,
      )
      robot.update_coordinates(robot.next_x, robot.next_y)
    end

  end
end
