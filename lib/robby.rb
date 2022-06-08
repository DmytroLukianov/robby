# COMMANDS = [
#   PLACE = "PLACE".freeze,
#   MOVE = "MOVE".freeze,
#   LEFT = "LEFT".freeze,
#   RIGHT = "RIGHT".freeze,
#   REPORT = "REPORT".freeze,
# ].freeze

EXIT_COMMAND = "EXIT".freeze,

puts "Robot successfully created, place it on the table"

while true
  puts "Enter the command:"
  command = gets.strip

  return if command == EXIT_COMMAND
end
