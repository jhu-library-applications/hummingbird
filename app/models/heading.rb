# frozen_string_literal: true

# A heading combines a category with a subcategory.
class Heading < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory

  def label
    "#{category.label} – #{subcategory.label}"
  end
end
