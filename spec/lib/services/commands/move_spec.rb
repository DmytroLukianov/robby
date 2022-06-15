# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/commands/move"

RSpec.describe Commands::Move do
  subject(:move) do
    described_class.call(
      table: table,
      robot: robot,
      command_args: nil,
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot, x: x, y: y, direction: direction) }
  let(:x) { 2 }
  let(:y) { 2 }

  before do
    table.cells[y][x] = robot
  end

  context "when next step is available" do
    context "when heading north" do
      let(:direction) { "NORTH" }

      it "removes robot from previous place on table" do
        expect { move }.to change { table.cells[y][x] }.from(robot).to(nil)
      end

      it "places robot in new place on table" do
        expect { move }.to change { table.cells[y + 1][x] }.from(nil).to(robot)
      end

      it "sets coordiante x for robot" do
        expect { move }.not_to change(robot, :x)
      end

      it "sets coordiante y for robot" do
        expect { move }.to change(robot, :y).from(y).to(y + 1)
      end

      it { expect { move }.not_to change(robot, :direction) }
    end

    context "when heading south" do
      let(:direction) { "SOUTH" }

      it "removes robot from previous place on table" do
        expect { move }.to change { table.cells[y][x] }.from(robot).to(nil)
      end

      it "places robot in new place on table" do
        expect { move }.to change { table.cells[y - 1][x] }.from(nil).to(robot)
      end

      it "sets coordiante x for robot" do
        expect { move }.not_to change(robot, :x)
      end

      it "sets coordiante y for robot" do
        expect { move }.to change(robot, :y).from(y).to(y - 1)
      end

      it { expect { move }.not_to change(robot, :direction) }
    end

    context "when heading west" do
      let(:direction) { "WEST" }

      it "removes robot from previous place on table" do
        expect { move }.to change { table.cells[y][x] }.from(robot).to(nil)
      end

      it "places robot in new place on table" do
        expect { move }.to change { table.cells[y][x - 1] }.from(nil).to(robot)
      end

      it "sets coordiante x for robot" do
        expect { move }.to change(robot, :x).from(x).to(x - 1)
      end

      it "sets coordiante y for robot" do
        expect { move }.not_to change(robot, :y)
      end

      it { expect { move }.not_to change(robot, :direction) }
    end

    context "when heading east" do
      let(:direction) { "EAST" }

      it "removes robot from previous place on table" do
        expect { move }.to change { table.cells[y][x] }.from(robot).to(nil)
      end

      it "places robot in new place on table" do
        expect { move }.to change { table.cells[y][x + 1] }.from(nil).to(robot)
      end

      it "sets coordiante x for robot" do
        expect { move }.to change(robot, :x).from(x).to(x + 1)
      end

      it "sets coordiante y for robot" do
        expect { move }.not_to change(robot, :y)
      end

      it { expect { move }.not_to change(robot, :direction) }
    end
  end

  context "when next step is not available" do
    context "when heading west" do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:direction) { "WEST" }

      it { expect { move }.to raise_error(InvalidCoordinatesError) }
    end

    context "when heading east" do
      let(:x) { 4 }
      let(:y) { 2 }
      let(:direction) { "EAST" }

      it { expect { move }.to raise_error(InvalidCoordinatesError) }
    end

    context "when heading south" do
      let(:x) { 3 }
      let(:y) { 0 }
      let(:direction) { "SOUTH" }

      it { expect { move }.to raise_error(InvalidCoordinatesError) }
    end

    context "when heading north" do
      let(:x) { 4 }
      let(:y) { 4 }
      let(:direction) { "NORTH" }

      it { expect { move }.to raise_error(InvalidCoordinatesError) }
    end
  end
end
