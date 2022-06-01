# frozen_string_literal: true

FactoryBot.define do
  factory :database_heading do
    database { FactoryBot.create(:database) }
    heading { FactoryBot.create(:heading) }
  end
end
