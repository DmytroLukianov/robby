class InvalidDirectionError < RobbyError
  def initialize(direction)
    super("Invalid direction: #{direction}")
  end
end
