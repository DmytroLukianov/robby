# frozen_string_literal: true

require_relative "./models/table"
require_relative "./models/robot"
require_relative "./services/commands_processor"

EXIT_COMMAND = "EXIT"
DEBUG_COMMAND = "DEBUG"
HELP_COMMAND = "HELP"

puts "Robot successfully created, place it on the table"
puts "Enter EXIT to finish work"

table = Table.new(width: 5, height: 5)
robot = Robot.new
debug_mode = false

loop do
  puts "Enter the command:"
  command = gets.strip.upcase

  case command
  when EXIT_COMMAND
    break
  when DEBUG_COMMAND
    debug_mode = !debug_mode
    next
  when HELP_COMMAND
    puts CommandsDescriptor.call
  else
    CommandsProcessor.call(table: table, robot: robot, command: command, debug_mode: debug_mode)
  end
rescue RobbyError => e
  puts "Error: #{e.message}"
end
