require_relative "../../operation"

module Commands
  class Move < Operation
    def call(field:, robot:, command_args: nil)
      field.move_item_to(
        x: robot.x,
        y: robot.y,
        new_x: robot.next_x,
        new_y: robot.next_y,
      )
      robot.set_coordinates(robot.next_x, robot.next_y)
    end
  end
end
