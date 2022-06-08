class Field < BaseModel
  attribute :width, Types::Coercible::Integer
  attribute :height, Types::Coercible::Integer

  attr_reader :cells

  def initialize(*args)
    super(*args)
    @cells = Array.new(height) { Array.new(width) }
  end

  def place(item:, x:, y:)
    cells[x][y] = item
  end
end
