# frozen_string_literal: true

json.extract! subheading, :id, :label, :created_at, :updated_at
json.url subheading_url(subheading, format: :json)
