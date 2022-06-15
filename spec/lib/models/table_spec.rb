# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/models/table"

RSpec.describe Table do
  subject(:table) { build(:table) }

  before do
    allow(Validators::CoordinatesValidator).to receive(:call)
  end

  it "creates table" do
    expect { table }.not_to raise_error
  end

  describe ".place" do
    subject(:place) { table.place(item: robot, x: x, y: y) }

    let(:table) { build(:table) }
    let(:robot) { build(:robot) }
    let(:x) { 2 }
    let(:y) { 3 }

    context "when cell is empty and coordinates is valid" do
      it "places item to passed coordinates" do
        expect { place }.to change { table.cells[y][x] }.from(nil).to(robot)
      end

      it "validates to coordinates" do
        place

        expect(Validators::CoordinatesValidator).to have_received(:call)
          .with(x: x, y: y, table: table)
      end
    end

    context "when cell already occupied" do
      before do
        table.cells[y][x] = "X"
      end

      it "places item to passed coordinates" do
        expect { place }.to raise_error InvalidCoordinatesError
      end
    end
  end

  describe ".move_item" do
    subject(:place) { table.move_item(from_x: 0, from_y: 0, to_x: to_x, to_y: to_y) }

    let(:table) { build(:table) }
    let(:robot) { build(:robot) }
    let(:to_x) { 1 }
    let(:to_y) { 4 }

    before do
      table.cells[0][0] = robot
    end

    context "when cell is empty and coordinates is valid" do
      it "places item to passed coordinates" do
        expect { place }.to change { table.cells[to_y][to_x] }.from(nil).to(robot)
      end

      it "removes item from passed coordinates" do
        expect { place }.to change { table.cells[0][0] }.from(robot).to(nil)
      end

      it "validates from coordinates" do
        place

        expect(Validators::CoordinatesValidator).to have_received(:call)
          .with(x: 0, y: 0, table: table)
      end

      it "validates to coordinates" do
        place

        expect(Validators::CoordinatesValidator).to have_received(:call)
          .with(x: to_x, y: to_y, table: table)
      end
    end
  end

  describe ".contains?" do
    subject(:contains?) { table.contains?(robot) }

    let(:table) { build(:table) }
    let(:robot) { build(:robot) }

    context "when passed item present in table" do
      before do
        table.cells[0][0] = robot
      end

      it { is_expected.to be true }
    end

    context "when passed item and another item present in table" do
      before do
        table.cells[0][0] = "X"
        table.cells[2][4] = robot
      end

      it { is_expected.to be true }
    end

    context "when another item present in table" do
      before do
        table.cells[0][0] = "X"
      end

      it { is_expected.to be false }
    end

    context "when table is empty" do
      it { is_expected.to be false }
    end
  end
end
