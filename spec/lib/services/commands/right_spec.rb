# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/commands/right"

RSpec.describe Commands::Right do
  subject(:run_command) do
    described_class.call(
      table: table,
      robot: robot,
      command_args: nil,
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot, x: 1, y: 2, direction: direction) }

  context "when heading north" do
    let(:direction) { "NORTH" }

    it "rotates robot to the east" do
      expect { run_command }.to change(robot, :direction).from(90.0).to(180.0)
    end
  end

  context "when heading east" do
    let(:direction) { "EAST" }

    it "rotates robot to the south" do
      expect { run_command }.to change(robot, :direction).from(180.0).to(270.0)
    end
  end

  context "when heading south" do
    let(:direction) { "SOUTH" }

    it "rotates robot to the west" do
      expect { run_command }.to change(robot, :direction).from(270.0).to(0.0)
    end
  end

  context "when heading west" do
    let(:direction) { "WEST" }

    it "rotates robot to the north" do
      expect { run_command }.to change(robot, :direction).from(0.0).to(90.0)
    end
  end
end
