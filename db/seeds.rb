# frozen_string_literal: true

require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Make this idempotent

# DatabaseHeading.destroy_all
# Database.destroy_all
# Heading.destroy_all
# Subheading.destroy_all
Vendor.destroy_all
# Database.destroy_all

# Create vendors

vendor_headers = %i[ID vendor]
CSV.foreach(Rails.root.join('test_data/tbl_dict_vendors.txt'), headers: vendor_headers) do |row|
  next if row[:ID] == 'ID'

  Vendor.new(id: row[:ID], brand_name: row[:vendor]).save!
end
