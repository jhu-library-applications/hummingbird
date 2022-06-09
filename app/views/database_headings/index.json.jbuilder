# frozen_string_literal: true

json.array! @database_headings, partial: 'database_headings/database_heading', as: :database_heading
