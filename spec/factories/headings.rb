# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    category { FactoryBot.create(:category) }
    subcategory { FactoryBot.create(:subcategory) }
  end
end
