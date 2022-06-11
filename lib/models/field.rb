class Field

  attr_reader :cells, :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width) }
  end

  def place(item:, x:, y:)
    raise InvalidCoordinatesError.new(x, y) unless coordinates_valid?(x, y)
    raise "Cell already occupied x: #{x}, y: #{y}" if cells[x][y]

    cells[x][y] = item
  end

  def move_item_to(x:, y:, new_x:, new_y:)
    raise "Invalid coordinates, x: #{x}, y: #{y}, new_x: #{new_x}, new_y: #{new_y}" unless coordinates_valid?(x, y) && coordinates_valid?(new_x, new_y)
    raise "Item not found by passed coordinates" unless cells[x][y]
    cells[new_x][new_y] = cells[x][y]
    cells[x][y] = nil
  end

  private

  def coordinates_valid?(x, y)
    (0...width).include?(x) && (0...height).include?(y)
  end

end
