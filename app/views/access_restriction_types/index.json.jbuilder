# frozen_string_literal: true

json.array! @access_restriction_types, partial: 'access_restriction_types/access_restriction_type',
                                       as: :access_restriction_type
