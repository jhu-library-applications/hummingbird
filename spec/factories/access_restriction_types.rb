# frozen_string_literal: true

FactoryBot.define do
  factory :access_restriction_type do
    type_label { FFaker::Lorem.word }
    note { FFaker::Lorem.paragraph }
    private { false }
  end
end
