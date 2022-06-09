# frozen_string_literal: true

FactoryBot.define do
  factory :subheading do
    label { FFaker::Education.major }
  end
end
