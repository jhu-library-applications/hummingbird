# frozen_string_literal: true

json.extract! database_heading, :id, :jhu_id, :heading_id, :subheading_id, :created_at, :updated_at
json.url database_heading_url(database_heading, format: :json)
