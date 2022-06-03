# frozen_string_literal: true

json.extract! heading, :id, :label, :created_at, :updated_at
json.url heading_url(heading, format: :json)
