require_relative "../operation"
require_relative "commands/place"
require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/move"
require_relative "commands/report"
require_relative "commands/debug_report"

class CommandsProcessor < Operation
  COMMANDS = [
    PLACE = "PLACE".freeze,
    MOVE = "MOVE".freeze,
    LEFT = "LEFT".freeze,
    RIGHT = "RIGHT".freeze,
    REPORT = "REPORT".freeze,
  ].freeze


  def call(field:, robot:, command:)
    command_name, args_str = command.split " "
    command_args = args_str&.split ","
    validate_command(command_name, robot)

    Object.const_get("Commands::#{command_name.capitalize}").call(field: field, robot: robot, command_args: command_args)
    Commands::DebugReport.call(field: field, robot: robot)
  end

  private

  def validate_command(command_name, robot)
    raise "InvalidCommandError" unless COMMANDS.include?(command_name)
    raise "PLACE sgould be first command" if command_name != PLACE && !robot.placed?
  end
end
