# frozen_string_literal: true

# The Database model. Database in this case is an acaedmic resource like EBSCO Academic Search Ultimate
# not a relational database.
class Database < ApplicationRecord
  belongs_to :vendor
  validates :url, uniqueness: true, presence: true
  validates :name, uniqueness: true, presence: true
  validates :jhu_id, uniqueness: true, presence: true

  has_many :database_headings, dependent: :destroy

  def label
    "#{name} (#{jhu_id})"
  end
end
