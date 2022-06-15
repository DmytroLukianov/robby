# frozen_string_literal: true

require_relative "../errors/invalid_coordinates_error"
require_relative "../errors/invalid_direction_error"
require_relative "../services/validators/direction_validator"

class Robot

  DIRECTIONS = {
    "WEST" => 0.0,
    "NORTH" => 90.0,
    "EAST" => 180.0,
    "SOUTH" => 270.0,
  }.freeze

  attr_reader :x, :y, :direction

  def initialize(x: nil, y: nil, direction: nil)
    @x = x
    @y = y
    Validators::DirectionValidator.call(direction: direction) if direction
    @direction = DIRECTIONS[direction]
  end

  def update_coordinates(x, y)
    @x = x
    @y = y
  end

  def update_direction(direction)
    Validators::DirectionValidator.call(direction: direction)
    @direction = DIRECTIONS[direction]
  end

  def rotate(degrees)
    result = direction + degrees
    @direction =
      if result >= 0 && result < 360
        result
      else
        result - (360 * (result / 360).floor)
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

end
