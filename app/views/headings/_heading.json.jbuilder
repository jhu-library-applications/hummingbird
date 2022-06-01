# frozen_string_literal: true

json.extract! heading, :id, :category_id, :subcategory_id, :created_at, :updated_at
json.url heading_url(heading, format: :json)
