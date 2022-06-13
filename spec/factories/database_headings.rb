# frozen_string_literal: true

FactoryBot.define do
  factory :database_heading do
    jhu_id { "JHU#{FFaker::Lorem.characters(5)}" }
    heading { FactoryBot.build(:heading) }
    subheading { FactoryBot.build(:subheading) }
    database { FactoryBot.build(:database) }
  end
end
