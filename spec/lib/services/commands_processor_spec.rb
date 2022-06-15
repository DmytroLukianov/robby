# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/services/commands_processor"
require_relative "../../../lib/services/validators/command_validator"

RSpec.describe CommandsProcessor do
  subject(:process_command) do
    described_class.call(
      table: table,
      robot: robot,
      command: command_name,
      debug_mode: debug_mode,
    )
  end

  let(:table) { build(:table) }
  let(:robot) { build(:robot) }
  let(:debug_mode) { false }

  context "when valid command passed" do
    before do
      allow(Validators::CommandValidator).to receive(:call)
      allow(Commands::Place).to receive(:call)
      allow(Commands::Move).to receive(:call)
      allow(Commands::Right).to receive(:call)
      allow(Commands::Left).to receive(:call)
      allow(Commands::Report).to receive(:call)
      allow(Commands::DebugReport).to receive(:call)

      process_command
    end

    context "when passed command PLACE" do
      let(:command_name) { "PLACE 1,2,WEST" }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: "PLACE",
          command_args: %w[1 2 WEST],
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Place" do
        expect(Commands::Place).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: %w[1 2 WEST],
        )
      end
    end

    context "when passed command MOVE" do
      let(:command_name) { "MOVE" }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: command_name,
          command_args: nil,
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Move" do
        expect(Commands::Move).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: nil,
        )
      end
    end

    context "when passed command RIGHT" do
      let(:command_name) { "RIGHT" }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: command_name,
          command_args: nil,
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Right" do
        expect(Commands::Right).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: nil,
        )
      end
    end

    context "when passed command LEFT" do
      let(:command_name) { "LEFT" }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: command_name,
          command_args: nil,
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Left" do
        expect(Commands::Left).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: nil,
        )
      end
    end

    context "when passed command REPORT" do
      let(:command_name) { "REPORT" }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: command_name,
          command_args: nil,
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Left" do
        expect(Commands::Report).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: nil,
        )
      end
    end

    context "when debug mode enabled" do
      let(:command_name) { "REPORT" }
      let(:debug_mode) { true }

      it "calls CommandValidator" do
        expect(Validators::CommandValidator).to have_received(:call).with(
          command_name: command_name,
          command_args: nil,
          table: table,
          robot: robot,
        )
      end

      it "calls Commands::Left" do
        expect(Commands::Report).to have_received(:call).with(
          table: table,
          robot: robot,
          command_args: nil,
        )
      end

      it "calls Commands::DebugReport" do
        expect(Commands::DebugReport).to have_received(:call).with(
          table: table,
          robot: robot,
        )
      end
    end
  end

  context "when other command passed" do
    let(:command_name) { "OTHER_COMMAND" }

    it "raises an error" do
      expect { process_command }.to raise_error(InvalidCommandError)
    end
  end

  context "when passed valid command without attributes" do
    let(:command_name) { "PLACE" }

    it "raises an error" do
      expect { process_command }.to raise_error(InvalidCommandError)
    end
  end

  context "when a valid command is passed in the wrong order" do
    # PLACE should be first
    let(:command_name) { "MOVE" }

    it "raises an error" do
      expect { process_command }.to raise_error(InvalidCommandError)
    end
  end
end
