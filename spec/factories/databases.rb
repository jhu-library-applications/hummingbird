# frozen_string_literal: true

FactoryBot.define do
  factory :database do
    jhu_id { "JHU#{FFaker::Lorem.characters(5)}" }
    vendor { FactoryBot.create(:vendor) }
    name { FFaker::Company.name }
    url { FFaker::Internet.http_url }
    enable_proxy { false }
    description { FFaker::Lorem.paragraph }
    internal_note { FFaker::Lorem.paragraph }
  end
end
