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
    when DIRECTIONS["WEST"], DIRECTIONS["EAST"]
      x
    when DIRECTIONS["NORTH"]
      x + 1
    when DIRECTIONS["SOUTH"]
      x - 1
    else
      raise "Unnknown direction"
    end
  end

  def next_y
    case direction
    when DIRECTIONS["NORTH"], DIRECTIONS["SOUTH"]
      y
    when DIRECTIONS["WEST"]
      y - 1
    when DIRECTIONS["EAST"]
      y + 1
    else
      raise "Unnknown direction"
    end
  end

  def readable_direction
    DIRECTIONS.key(direction)
  end

  # def next_step_coordinates
  #   case direction
  #   when DIRECTIONS["WEST"]
  #     { x: x, y: (y - 1) }
  #   when DIRECTIONS["NORTH"]
  #     { x: (x - 1), y: y }
  #   when DIRECTIONS["EAST"]
  #     { x: x, y: (y + 1) }
  #   when DIRECTIONS["SOUTH"]
  #     { x: (x + 1), y: y }
  #   else
  #     raise "Unnknown direction"
  #   end
  # end

  private

  def validate_direction(new_direction)
    return if DIRECTIONS.keys.include?(new_direction)

    # TODO: add custom error
    raise "Invalid direction"
  end

  def validate_coordinates(x, y)
    return if x.is_a?(Integer) && y.is_a?(Integer)

    # TODO: add custom error
    raise "Invalid coordinates type"
  end
end
