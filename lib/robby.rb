require_relative "./models/field"
require_relative "./models/robot"
require_relative "./services/commands_processor"

EXIT_COMMAND = "EXIT".freeze

puts "Robot successfully created, place it on the table"

field = Field.new(width: 5, height: 5)
robot = Robot.new

while true
  puts "Enter the command:"
  command = gets.strip.upcase

  CommandsProcessor.call(field: field, robot: robot, command: command)

  return if command == EXIT_COMMAND
end
