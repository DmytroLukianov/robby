class Robot < BaseModel

  attribute :x, Types::Coercible::Integer
  attribute :y, Types::Coercible::Integer
  attribute :direction, Types::String.enum("NORTH", "SOUTH", "EAST", "WEST")

  def move
  end

  def left
  end

  def right
  end

  def report
  end
end
