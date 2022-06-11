require_relative "../../operation"

module Commands
  class Place < Operation
    def call(field:, robot:, command_args:)
      x, y, direction = command_args[0].to_i, command_args[1].to_i, command_args[2]

      raise "Robot already placed" if robot.placed?
      field.place(item: robot, x: x, y: y)
      robot.set_coordinates(x, y)
      robot.set_direction(direction)
    end
  end
end
