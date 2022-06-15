# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/services/validators/direction_validator"

RSpec.describe Validators::DirectionValidator do
  subject(:validate) do
    described_class.call(direction: direction)
  end

  %w[WEST NORTH EAST SOUTH].each do |valid_direction|
    context "when direction to #{valid_direction}" do
      let(:direction) { valid_direction }

      it { expect { validate }.not_to raise_error }
    end
  end

  context "when direction is invalid" do
    let(:direction) { "QWE" }

    it { expect { validate }.to raise_error(InvalidDirectionError, "Invalid direction: QWE") }
  end
end
