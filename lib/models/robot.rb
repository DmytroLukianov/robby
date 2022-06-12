require_relative "../errors/invalid_coordinates_error"
require_relative "../errors/invalid_direction_error"

class Robot

  DIRECTIONS = {
    "WEST" => 0.0,
    "NORTH" => 90.0,
    "EAST" => 180.0,
    "SOUTH" => 270.0,
  }

  attr_reader :x, :y, :direction

  def placed?
    !!x && !!y && !!direction
  end

  def set_coordinates(x, y)
    validate_coordinates(x, y)
    @x = x
    @y = y
  end

  def set_direction(direction)
    validate_direction(direction)
    @direction = DIRECTIONS[direction]
  end

  def rotate(degrees)
    result = direction + degrees
    @direction =
      if result < 0 || result >= 360
        result - 360 * (result / 360).floor
      else
        result
      end
  end

  def next_x
    case direction
    when DIRECTIONS["NORTH"], DIRECTIONS["SOUTH"]
      x
    when DIRECTIONS["EAST"]
      x + 1
    when DIRECTIONS["WEST"]
      x - 1
    else
      raise InvalidDirectionError, "Unnknown direction '#{direction}' for next X coordinate"
    end
  end

  def next_y
    case direction
    when DIRECTIONS["WEST"], DIRECTIONS["EAST"]
      y
    when DIRECTIONS["NORTH"]
      y + 1
    when DIRECTIONS["SOUTH"]
      y - 1
    else
      raise InvalidDirectionError, "Unnknown direction '#{direction}' for next Y coordinate"
    end
  end

  def readable_direction
    DIRECTIONS.key(direction)
  end

  private

  def validate_direction(new_direction)
    return if DIRECTIONS.keys.include?(new_direction)

    raise InvalidDirectionError, "Invalid direction: #{new_direction}"
  end

  def validate_coordinates(x, y)
    return if x.is_a?(Integer) && y.is_a?(Integer)

    raise InvalidCoordinatesError, "Invalid coordinates type"
  end
end
