# frozen_string_literal: true

require_relative "../operation"
require_relative "../errors/invalid_command_error"
require_relative "commands/place"
require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/move"
require_relative "commands/report"
require_relative "commands/debug_report"
require_relative "validators/command_validator"

class CommandsProcessor < Operation

  def call(table:, robot:, command:, debug_mode: false)
    command_name, args_str = command.split
    command_args = args_str&.split ","
    Validators::CommandValidator.call(
      command_name: command_name,
      command_args: command_args,
      table: table,
      robot: robot,
    )

    Object.const_get("Commands::#{command_name.capitalize}").call(
      table: table,
      robot: robot,
      command_args: command_args,
    )

    Commands::DebugReport.call(table: table, robot: robot) if debug_mode
  end

end
