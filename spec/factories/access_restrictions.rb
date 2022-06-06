# frozen_string_literal: true

FactoryBot.define do
  factory :access_restriction do
    database { FactoryBot.build(:database) }
    jhu_id { database.jhu_id }
    access_restriction_type { FactoryBot.build(:access_restriction_type) }
    note { FFaker::Lorem.paragraph }
    private_url { FFaker::Internet.http_url }
  end
end
