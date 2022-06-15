# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/services/commands_descriptor"

RSpec.describe CommandsDescriptor do
  subject(:help_info) { described_class.call }

  context "when called without arguments" do
    it "returns description for all commands" do
      %w[PLACE MOVE LEFT RIGHT REPORT].each do |command_name|
        expect(help_info).to include command_name
      end
    end
  end

  context "when called for a specific command" do
    subject(:help_info) { described_class.call(command_name: command_name) }

    let(:command_name) { "PLACE" }

    it "contains description PLACE command" do
      expect(help_info).to include command_name
    end

    it "does not contain description for other valid commands" do
      %w[MOVE LEFT RIGHT REPORT].each do |command_name|
        expect(help_info).not_to include command_name
      end
    end
  end
end
