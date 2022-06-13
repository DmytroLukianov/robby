# frozen_string_literal: true

require_relative "../../operation"
require_relative "../../errors/invalid_direction_error"
require_relative "../../models/robot"

module Validators
  class DirectionValidator < Operation

    def call(direction:)
      return if Robot::DIRECTIONS.keys.include?(direction)

      raise InvalidDirectionError, "Invalid direction: #{direction}"
    end

  end
end
