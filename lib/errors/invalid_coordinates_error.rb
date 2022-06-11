class InvalidCoordinatesError < RobbyError
  def initialize(x, y)
    super("Invalid coordinates: x: #{x}, y: #{y}")
  end
end
