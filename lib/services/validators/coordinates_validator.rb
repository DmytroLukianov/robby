# frozen_string_literal: true

require_relative "../../operation"
require_relative "../../errors/invalid_coordinates_error"

module Validators
  class CoordinatesValidator < Operation

    def call(x:, y:, table:)
      raise InvalidCoordinatesError, "Invalid coordinates type" unless valid_type?(x, y)
      raise InvalidCoordinatesError, "Coordinates out of table range: x=#{x}, y=#{y}" unless valid_range?(x, y, table)
    end

    private

    def valid_type?(x, y)
      x.is_a?(Integer) && y.is_a?(Integer)
    end

    def valid_range?(x, y, table)
      (0...table.width).include?(x) && (0...table.height).include?(y)
    end

  end
end
