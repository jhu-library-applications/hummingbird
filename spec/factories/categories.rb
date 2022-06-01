# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    label { FFaker::Education.major }
  end
end
