# frozen_string_literal: true

require_relative "../errors/invalid_coordinates_error"
require_relative "../services/validators/coordinates_validator"

class Table

  attr_reader :cells, :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width) }
  end

  def place(item:, x:, y:)
    Validators::CoordinatesValidator.call(x: x, y: y, table: self)
    raise InvalidCoordinatesError, "Cell already occupied x: #{x}, y: #{y}" if cells[y][x]

    cells[y][x] = item
  end

  def move_item(from_x:, from_y:, to_x:, to_y:)
    Validators::CoordinatesValidator.call(x: from_x, y: from_y, table: self)
    Validators::CoordinatesValidator.call(x: to_x, y: to_y, table: self)
    raise InvalidCoordinatesError, "Item not found by passed coordinates" unless cells[from_y][from_x]
    return if from_y == to_y && from_x == to_x

    cells[to_y][to_x] = cells[from_y][from_x]
    cells[from_y][from_x] = nil
  end

  def contains?(item)
    cells.each do |row|
      return true if row.include?(item)
    end

    false
  end

end
