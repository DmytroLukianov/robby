# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/validators/coordinates_validator"

RSpec.describe Validators::CoordinatesValidator do
  subject(:validate) do
    described_class.call(x: x, y: y, table: table)
  end

  let(:table) { build(:table, width: 5, height: 5) }
  let(:x) { 3 }
  let(:y) { 3 }

  it { expect { validate }.not_to raise_error }

  context "when x is out of range" do
    let(:x) { -1 }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Coordinates out of table range: x=#{x}, y=#{y}") }
  end

  context "when y is out of range" do
    let(:y) { 5 }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Coordinates out of table range: x=#{x}, y=#{y}") }
  end

  context "when x and y is out of range" do
    let(:x) { 5 }
    let(:y) { -1 }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Coordinates out of table range: x=#{x}, y=#{y}") }
  end

  context "when x has invalid type" do
    let(:x) { "1" }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Invalid coordinates type") }
  end

  context "when y has invalid type" do
    let(:y) { "1" }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Invalid coordinates type") }
  end

  context "when x and y has invalid type" do
    let(:x) { "4" }
    let(:y) { "1" }

    it { expect { validate }.to raise_error(InvalidCoordinatesError, "Invalid coordinates type") }
  end
end
