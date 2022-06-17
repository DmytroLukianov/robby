# frozen_string_literal: true

require "rspec"
require_relative "../../lib/robby"
require_relative "../../lib/models/table"
require_relative "../../lib/models/robot"
require_relative "../../lib/services/commands_processor"

RSpec.describe Robby do
  subject(:run_script) { described_class.run }

  context "when robot moves" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE 0,0,NORTH\n",
        "MOVE\n",
        "REPORT\n",
        "EXIT\n",
      )
    end

    it "outputs valid coordinates" do
      expect { run_script }.to output(/Output: 0,1,NORTH/).to_stdout
    end
  end

  context "when robot rotates" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE 0,0,NORTH\n",
        "LEFT\n",
        "REPORT\n",
        "EXIT\n",
      )
    end

    it "outputs valid coordinates" do
      expect { run_script }.to output(/Output: 0,0,WEST/).to_stdout
    end
  end

  context "when robot moves and rotates" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE 1,2,EAST\n",
        "MOVE\n",
        "MOVE\n",
        "LEFT\n",
        "MOVE\n",
        "REPORT\n",
        "EXIT\n",
      )
    end

    it "outputs valid coordinates" do
      expect { run_script }.to output(/Output: 3,3,NORTH/).to_stdout
    end
  end

  context "when robot moves out of table range" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE 0,0,SOUTH\n",
        "MOVE\n",
        "REPORT\n",
        "EXIT\n",
      )
    end

    it "outputs valid coordinates" do
      expect { run_script }.to output(/Output: 0,0,SOUTH/).to_stdout
    end
  end

  context "when PLACE passed with invalid attributes" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE WEST,1,2\n",
        "EXIT\n",
      )
    end

    it "outputs invalid command error" do
      expect { run_script }.to output(/Error: Ivalid arguments/).to_stdout
    end
  end

  context "when PLACE passed without attributes" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "PLACE\n",
        "EXIT\n",
      )
    end

    it "outputs invalid command error" do
      expect { run_script }.to output(/Error: Ivalid arguments/).to_stdout
    end
  end

  context "when first command not PLACE" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "MOVE\n",
        "REPORT\n",
        "EXIT\n",
      )
    end

    it "outputs info about PLACE command" do
      expect { run_script }.to output(/Error: PLACE should be first command/).to_stdout
    end
  end

  context "when use invalid commands" do
    before do
      allow(described_class).to receive(:gets).and_return(
        "QWE\n",
        "EXIT\n",
      )
    end

    it "outputs invalid command error" do
      expect { run_script }.to output(/Invalid command: QWE/).to_stdout
    end
  end
end
