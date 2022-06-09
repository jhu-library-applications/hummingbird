# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    label { FFaker::Education.major }
  end
end
