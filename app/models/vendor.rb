# frozen_string_literal: true

class Vendor < ApplicationRecord
  validates :brand_name, uniqueness: true
  paginates_per 25
  include PgSearch::Model

  pg_search_scope :search_brand_name_asc, against: :brand_name,
                                          using: {
                                            tsearch: { prefix: true }
                                          }, order_within_rank: 'vendors.brand_name ASC'

  pg_search_scope :search_brand_name_desc, against: :brand_name,
                                           using: {
                                             tsearch: { prefix: true }
                                           }, order_within_rank: 'vendors.brand_name DESC'
end
