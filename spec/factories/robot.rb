require_relative "../../lib/models/robot"

FactoryBot.define do
  factory :robot do
    x { nil }
    y { nil }
    direction { nil }

    skip_create
    initialize_with { new(x: x, y: y, direction: direction) }

    trait :with_values do
      x { 3 }
      y { 2 }
      direction { "NORTH" }
    end
  end
end
