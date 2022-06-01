# frozen_string_literal: true

json.extract! category, :id, :label, :created_at, :updated_at
json.url category_url(category, format: :json)
