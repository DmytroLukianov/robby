# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/validators/command_validator"

RSpec.describe Validators::CommandValidator do
  subject(:validate) do
    described_class.call(
      command_name: command_name,
      command_args: command_args,
      table: table,
      robot: robot,
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot) }

  context "when robot is not placed" do
    %w[MOVE LEFT RIGHT REPORT].each do |valid_command|
      context "when pass #{valid_command} command" do
        let(:command_name) { valid_command }
        let(:command_args) { nil }

        it { expect { validate }.to raise_error(InvalidCommandError, "PLACE should be first command") }
      end
    end

    context "when pass PLACE command with arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { [1, 2, "WEST"] }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass PLACE command with invalid arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { [1, 2, 3] }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass PLACE command without arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { nil }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass invalid command without arguments" do
      let(:command_name) { "QWE" }
      let(:command_args) { nil }
      let(:expected_error_msg) { "Invalid command: QWE. Valid commands: PLACE, MOVE, LEFT, RIGHT, REPORT" }

      it { expect { validate }.to raise_error InvalidCommandError, expected_error_msg }
    end
  end

  context "when robot is placed" do
    before do
      allow(table).to receive(:contains?).with(robot).and_return(true)
    end

    %w[MOVE LEFT RIGHT REPORT].each do |valid_command|
      context "when pass #{valid_command} command" do
        let(:command_name) { valid_command }
        let(:command_args) { nil }

        it { expect { validate }.not_to raise_error }
      end
    end

    context "when pass PLACE command with arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { [1, 2, "WEST"] }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass PLACE command with invalid arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { [1, 2, 3] }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass PLACE command without arguments" do
      let(:command_name) { "PLACE" }
      let(:command_args) { nil }

      it { expect { validate }.to raise_error InvalidCommandError }
    end

    context "when pass invalid command without arguments" do
      let(:command_name) { "QWE" }
      let(:command_args) { nil }
      let(:expected_error_msg) { "Invalid command: QWE. Valid commands: PLACE, MOVE, LEFT, RIGHT, REPORT" }

      it { expect { validate }.to raise_error InvalidCommandError, expected_error_msg }
    end
  end
end
