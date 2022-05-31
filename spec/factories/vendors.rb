# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    brand_name { FFaker::Company.name }
  end
end
