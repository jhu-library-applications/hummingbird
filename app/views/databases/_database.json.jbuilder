# frozen_string_literal: true

json.extract! database, :id, :vendor_id, :name, :url, :enable_proxy, :description, :internal_note, :created_at,
              :updated_at
json.url database_url(database, format: :json)
