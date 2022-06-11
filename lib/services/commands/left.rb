require_relative "../../operation"

module Commands
  class Left < Operation
    def call(field:, robot:, command_args: nil)
      robot.rotate(-90.0)
    end
  end
end
