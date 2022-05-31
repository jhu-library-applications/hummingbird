# frozen_string_literal: true

class Vendor < ApplicationRecord
  validates :brand_name, uniqueness: true
end
