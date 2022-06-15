# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/commands/debug_report"

RSpec.describe Commands::DebugReport do
  subject(:report) do
    described_class.call(
      table: table,
      robot: robot,
    )
  end

  let(:table) { build(:table, width: 2, height: 2) }
  let(:robot) { build(:robot, x: 1, y: 1, direction: "WEST") }

  before do
    table.place(item: robot, x: 1, y: 1)
  end

  it "outputs current robot position and direction" do
    expect { report }.to output("Position: 1,1,WEST, 0.0°\n- ←\n- -\n").to_stdout
  end
end
