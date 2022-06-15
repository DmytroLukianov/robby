# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/commands/place"

RSpec.describe Commands::Place do
  subject(:place) do
    described_class.call(
      table: table,
      robot: robot,
      command_args: [x, y, direction],
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot) }
  let(:x) { 1 }
  let(:y) { 2 }
  let(:direction) { "WEST" }

  context "when table does not contain robot" do
    it "places robot on table" do
      expect { place }.to change { table.cells[y][x] }.from(nil).to(robot)
    end

    it "sets coordiante x for robot" do
      expect { place }.to change(robot, :x).from(nil).to(x)
    end

    it "sets coordiante y for robot" do
      expect { place }.to change(robot, :y).from(nil).to(y)
    end

    it "sets direction for robot" do
      expect { place }.to change(robot, :direction).from(nil).to(0.0)
    end
  end

  context "when table contains robot" do
    let(:robot) { build(:robot, x: 0, y: 0, direction: "NORTH") }

    before do
      table.cells[0][0] = robot
    end

    it "removes robot from previous place on table" do
      expect { place }.to change { table.cells[0][0] }.from(robot).to(nil)
    end

    it "places robot in new place on table" do
      expect { place }.to change { table.cells[y][x] }.from(nil).to(robot)
    end

    it "sets coordiante x for robot" do
      expect { place }.to change(robot, :x).from(0).to(x)
    end

    it "sets coordiante y for robot" do
      expect { place }.to change(robot, :y).from(0).to(y)
    end

    it "sets direction for robot" do
      expect { place }.to change(robot, :direction).from(90.0).to(0.0)
    end
  end

  context "when x coordinate is out of table range" do
    let(:x) { -1 }

    it { expect { place }.to raise_error(InvalidCoordinatesError) }
  end

  context "when y coordinate is out of table range" do
    let(:y) { -1 }

    it { expect { place }.to raise_error(InvalidCoordinatesError) }
  end

  context "when direction is invalid" do
    let(:direction) { "QWE" }

    it { expect { place }.to raise_error(InvalidDirectionError) }
  end
end
