require "../operation"

class CommandsProcessor < Operation
  COMMANDS = {
    "PLACE" => Commands::Place,
    "MOVE" => Commands::Move,
    "LEFT" => Commands::Left,
    "RIGHT" => Commands::Right,
    "REPORT" => Commands::Report,
  }

  def call(command:, robot:, field:)
    # TODO: add validator
    name, args_str = command.split " "
    args = args_str.split(",")

  end

end
