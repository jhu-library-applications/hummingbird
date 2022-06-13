# frozen_string_literal: true

class DatabaseHeading < ApplicationRecord
  belongs_to :heading
  belongs_to :subheading
  belongs_to :database
  before_save :set_jhu_id

  private

  def set_jhu_id
    self.jhu_id = Database.find(database.id).jhu_id
  end
end
