require_relative "../errors/invalid_coordinates_error"

class Field

  attr_reader :cells, :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width) }
  end

  def place(item:, x:, y:)
    raise InvalidCoordinatesError, "Invalid coordinates: x: #{x}, y: #{y}" unless coordinates_valid?(x, y)
    raise InvalidCoordinatesError, "Cell already occupied x: #{x}, y: #{y}" if cells[y][x]

    cells[y][x] = item
  end

  def move_item_to(x:, y:, new_x:, new_y:)
    raise InvalidCoordinatesError, "Invalid coordinates, x: #{x}, y: #{y}, new_x: #{new_x}, new_y: #{new_y}" unless coordinates_valid?(x, y) && coordinates_valid?(new_x, new_y)
    raise InvalidCoordinatesError, "Item not found by passed coordinates" unless cells[y][x]
    cells[new_y][new_x] = cells[y][x]
    cells[y][x] = nil
  end

  private

  def coordinates_valid?(x, y)
    (0...width).include?(x) && (0...height).include?(y)
  end

end
