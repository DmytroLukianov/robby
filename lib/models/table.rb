# frozen_string_literal: true

require_relative "../errors/invalid_coordinates_error"

class Table

  attr_reader :cells, :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width) }
  end

  def place(item:, x:, y:)
    raise InvalidCoordinatesError, "Cell already occupied x: #{x}, y: #{y}" if cells[y][x]

    cells[y][x] = item
  end

  def move_item(from_x:, from_y:, to_x:, to_y:)
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
