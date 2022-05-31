# frozen_string_literal: true

json.array! @databases, partial: 'databases/database', as: :database
