# frozen_string_literal: true

json.extract! access_restriction_type, :id, :type, :note, :private, :created_at, :updated_at
json.url access_restriction_type_url(access_restriction_type, format: :json)
