# frozen_string_literal: true

require_relative "../operation"

class CommandsDescriptor < Operation

  PLACE = "PLACE"
  MOVE = "MOVE"
  LEFT = "LEFT"
  RIGHT = "RIGHT"
  REPORT = "REPORT"

  COMMANDS = {
    PLACE => {
      description: "Places Robby on the table by coordinates",
      args: [
        { name: "X", format: "Integer", description: "X coordinate", regex: /\d+/ },
        { name: "Y", format: "Integer", description: "Y coordinate", regex: /\d+/ },
        {
          name: "F",
          format: "String",
          description: "Facing, valid options: #{Robot::DIRECTIONS.keys.join(", ")}",
          regex: /[a-zA-Z]+/,
        },
      ],
    },
    MOVE => { description: "Robby moves ahead by 1 step in current direction" },
    LEFT => { description: "Robby turns left by 90 degrees" },
    RIGHT => { description: "Robby turns right by 90 degrees" },
    REPORT => { description: "Robby outputs current position and direction" },
  }.freeze

  def call(command_name: nil)
    if command_name
      command_help_info(command_name)
    else
      COMMANDS.keys.map { |command| command_help_info(command) }.join
    end
  end

  private

  def command_help_info(command_name)
    command_info = COMMANDS[command_name]
    command_args = command_info[:args]
    description = ["\n================================"]
    title = command_name
    title += " #{command_args.map { |arg| "<#{arg[:name]}>" }.join(", ")}" if command_args
    description << title
    description << "================================"
    description << command_info[:description]

    command_args&.each do |arg_info|
      description << "#{arg_info[:name]} (#{arg_info[:format]}) - #{arg_info[:description]}"
    end

    description << "-------------------------------\n"

    description.join("\n")
  end

end
