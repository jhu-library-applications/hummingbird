# frozen_string_literal: true

class AccessRestriction < ApplicationRecord
  before_save :normalize_blank_values

  belongs_to :access_restriction_type
  belongs_to :database

  validates :private_url, uniqueness: true, allow_nil: true

  private

  def normalize_blank_values
    attributes.each do |column, _value|
      self[column].present? || self[column] = nil
    end
  end
end
