require_relative "../../lib/models/table"

FactoryBot.define do
  factory :table do
    width { 5 }
    height  { 5 }

    skip_create
    initialize_with { new(width: width, height: height) }
  end
end
