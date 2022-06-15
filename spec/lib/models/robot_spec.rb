# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/models/robot"

RSpec.describe Robot do
  subject(:robot) { build(:robot, :with_values) }

  before do
    allow(Validators::DirectionValidator).to receive(:call)
  end

  it "creates robot" do
    expect { robot }.not_to raise_error
  end

  it "validates direction" do
    robot

    expect(Validators::DirectionValidator).to have_received(:call)
  end

  describe ".update_coordinates" do
    subject(:update_coordinates) { robot.update_coordinates(x, y) }

    let(:robot) { build(:robot) }
    let(:x) { 2 }
    let(:y) { 3 }

    it "updates x" do
      expect { update_coordinates }.to change(robot, :x).from(nil).to(x)
    end

    it "updates y" do
      expect { update_coordinates }.to change(robot, :y).from(nil).to(y)
    end
  end

  describe ".update_direction" do
    subject(:update_direction) { robot.update_direction("NORTH") }

    let(:robot) { build(:robot) }

    it "updates direction" do
      expect { update_direction }.to change(robot, :direction).from(nil).to(90.0)
    end

    it "validates direction" do
      update_direction

      expect(Validators::DirectionValidator).to have_received(:call)
    end
  end

  describe ".rotate" do
    subject(:rotate) { robot.rotate(degrees) }

    let(:robot) { build(:robot, direction: "NORTH") }

    context "when rotate to 90 degrees" do
      let(:degrees) { 90.0 }

      it "updates direction" do
        expect { rotate }.to change(robot, :direction).from(90.0).to(180.0)
      end
    end

    context "when rotate to -90 degrees" do
      let(:degrees) { -90.0 }

      it "updates direction" do
        expect { rotate }.to change(robot, :direction).from(90.0).to(0.0)
      end
    end

    context "when rotate to -180 degrees" do
      let(:degrees) { -180.0 }

      it "updates direction" do
        expect { rotate }.to change(robot, :direction).from(90.0).to(270.0)
      end
    end

    context "when rotate to 360 degrees" do
      let(:degrees) { 360.0 }

      it "does not update direction" do
        expect { rotate }.not_to change(robot, :direction)
      end
    end

    context "when rotate to -450 degrees" do
      let(:degrees) { -450.0 }

      it "updates direction" do
        expect { rotate }.to change(robot, :direction).from(90.0).to(0.0)
      end
    end

    context "when rotate to 1170 degrees" do
      let(:degrees) { 1170.0 }

      it "updates direction" do
        expect { rotate }.to change(robot, :direction).from(90.0).to(180.0)
      end
    end
  end

  describe ".next_x" do
    subject(:next_x) { robot.next_x }

    let(:robot) { build(:robot, x: x, y: y, direction: direction) }
    let(:x) { 3 }
    let(:y) { 3 }

    context "when direction to EAST" do
      let(:direction) { "EAST" }

      it "changes x by +1" do
        expect(next_x).to eq(x + 1)
      end
    end

    context "when direction to WEST" do
      let(:direction) { "WEST" }

      it "changes x by -1" do
        expect(next_x).to eq(x - 1)
      end
    end

    context "when direction to NORTH" do
      let(:direction) { "NORTH" }

      it "does not change x" do
        expect(next_x).to eq(x)
      end
    end

    context "when direction to SOUTH" do
      let(:direction) { "SOUTH" }

      it "does not change x" do
        expect(next_x).to eq(x)
      end
    end
  end

  describe ".next_y" do
    subject(:next_y) { robot.next_y }

    let(:robot) { build(:robot, x: x, y: y, direction: direction) }
    let(:x) { 3 }
    let(:y) { 3 }

    context "when direction to NORTH" do
      let(:direction) { "NORTH" }

      it "changes x by +1" do
        expect(next_y).to eq(y + 1)
      end
    end

    context "when direction to SOUTH" do
      let(:direction) { "SOUTH" }

      it "changes x by -1" do
        expect(next_y).to eq(y - 1)
      end
    end

    context "when direction to WEST" do
      let(:direction) { "WEST" }

      it "does not change x" do
        expect(next_y).to eq(y)
      end
    end

    context "when direction to EAST" do
      let(:direction) { "EAST" }

      it "does not change x" do
        expect(next_y).to eq(y)
      end
    end
  end

  describe ".readable_direction" do
    subject(:readable_direction) { robot.readable_direction }

    let(:robot) { build(:robot, direction: direction) }

    %w[WEST NORTH EAST SOUTH].each do |facing|
      context "when direction to #{facing}" do
        let(:direction) { facing }

        it "does not change x" do
          expect(readable_direction).to eq(facing)
        end
      end
    end
  end
end
