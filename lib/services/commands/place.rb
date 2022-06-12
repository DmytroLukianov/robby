require_relative "../../operation"

module Commands
  class Place < Operation
    def call(field:, robot:, command_args:)
      x, y, direction = command_args[0].to_i, command_args[1].to_i, command_args[2]

      if robot.placed?
        field.move_item_to(
          x: robot.x,
          y: robot.y,
          new_x: x,
          new_y: y,
        )
      else
        field.place(item: robot, x: x, y: y)
      end

      robot.set_coordinates(x, y)
      robot.set_direction(direction)
    end
  end
end
