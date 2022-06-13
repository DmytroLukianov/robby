# frozen_string_literal: true

require_relative "../../operation"

module Commands
  class Report < Operation

    def call(table:, robot:, command_args: nil)
      puts "Output: #{robot.x},#{robot.y},#{robot.readable_direction}"
    end

  end
end
