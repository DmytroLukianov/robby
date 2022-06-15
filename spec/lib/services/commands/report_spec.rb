# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/commands/report"

RSpec.describe Commands::Report do
  subject(:report) do
    described_class.call(
      table: table,
      robot: robot,
      command_args: nil,
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot, x: 1, y: 2, direction: direction) }
  let(:direction) { "NORTH" }

  it "outputs current robot position and direction" do
    expect { report }.to output("Output: #{robot.x},#{robot.y},#{direction}\n").to_stdout
  end
end
