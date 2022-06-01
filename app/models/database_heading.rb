# frozen_string_literal: true

class DatabaseHeading < ApplicationRecord
  belongs_to :database
  belongs_to :heading
end
