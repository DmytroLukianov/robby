require_relative "../operation"
require_relative "../errors/invalid_command_error"
require_relative "commands/place"
require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/move"
require_relative "commands/report"
require_relative "commands/debug_report"

class CommandsProcessor < Operation
  PLACE = "PLACE".freeze
  MOVE = "MOVE".freeze
  LEFT = "LEFT".freeze
  RIGHT = "RIGHT".freeze
  REPORT = "REPORT".freeze

  COMMANDS = {
    PLACE => {
      description: "Places Robby on the table by coordinates",
      args: [
        { name: "X", format: "Integer", description: "X coordinate", regex: /\d+/ },
        { name: "Y", format: "Integer", description: "Y coordinate", regex: /\d+/ },
        { name: "DIRECTION", format: "String", description: "Valid options: #{Robot::DIRECTIONS.keys.join(", ")}", regex: /[a-zA-Z]+/ },
      ]
    },
    MOVE => { description: "Places Robby on the table by coordinates" },
    LEFT => { description: "Places Robby on the table by coordinates" },
    RIGHT => { description: "Places Robby on the table by coordinates" },
    REPORT => { description: "Places Robby on the table by coordinates" },
  }.freeze


  def call(field:, robot:, command:, debug_mode: false)
    command_name, args_str = command.split " "
    command_args = args_str&.split ","
    validate_command(command_name, command_args, robot)

    Object.const_get("Commands::#{command_name.capitalize}").call(field: field, robot: robot, command_args: command_args)

    Commands::DebugReport.call(field: field, robot: robot) if debug_mode
  end

  private

  def validate_command(command_name, command_args, robot)
    raise InvalidCommandError, "Invalid command: #{command_name}. Valid commands: #{COMMANDS.keys.join(", ")}" unless COMMANDS.keys.include?(command_name)
    # TODO: check how robot.placed? can be changed
    raise InvalidCommandError, "PLACE should be first command" if command_name != PLACE && !robot.placed?
    validate_command_with_args(command_name, command_args)
  end

  def validate_command_with_args(command_name, command_args)
    COMMANDS[command_name][:args]&.each_with_index do |arg_info, i|
      passed_arg = command_args&.fetch(i)
      if passed_arg !~ arg_info[:regex]
        error_message =
          "Ivalid argument ##{i + 1}: #{passed_arg}.\n" + command_help_info(command_name)

        raise InvalidCommandError, error_message
      end
    end
  end

  # TODO: implement help for each command
  def command_help_info(command_name)
    command_info = COMMANDS[command_name]
    command_args = command_info[:args]
    description = "Command info:\n#{command_name}"
    description += "#{command_args.map{ |arg| arg[:name] }.join(", ")}" if command_args
    description += "\n================================"
    description += "\n #{command_info[:description]}"
    description += "\n================================"

    command_args&.each do |arg_info|
      description += "\n#{arg_info[:name]} (#{arg_info[:format]}) - #{arg_info[:description]}"
    end

    description
  end

end
