# frozen_string_literal: true

json.extract! access_restriction, :id, :jhu_id, :restriction_type_id, :database_id, :note, :private_url, :created_at,
              :updated_at
json.url access_restriction_url(access_restriction, format: :json)
