# frozen_string_literal: true

json.array! @access_restrictions, partial: 'access_restrictions/access_restriction', as: :access_restriction
