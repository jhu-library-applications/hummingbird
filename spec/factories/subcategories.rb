# frozen_string_literal: true

FactoryBot.define do
  factory :subcategory do
    label { FFaker::Education.major }
  end
end
