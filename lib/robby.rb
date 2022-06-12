require_relative "./models/field"
require_relative "./models/robot"
require_relative "./services/commands_processor"

EXIT_COMMAND = "EXIT".freeze
DEBUG_COMMAND = "DEBUG".freeze

puts "Robot successfully created, place it on the table"
puts "Enter EXIT to finish work"

field = Field.new(width: 5, height: 5)
robot = Robot.new
debug_mode = false

while true
  begin
    puts "Enter the command:"
    command = gets.strip.upcase
    return if command == EXIT_COMMAND
    debug_mode = !debug_mode if command == DEBUG_COMMAND

    CommandsProcessor.call(field: field, robot: robot, command: command, debug_mode: debug_mode)
  rescue RobbyError => e
    puts "Error: #{e.message}"
  end
end
