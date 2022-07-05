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

Vendor.destroy_all
Heading.destroy_all
Subheading.destroy_all
Database.destroy_all
DatabaseHeading.destroy_all

# Create vendors
vendor_headers = %i[ID vendor]
CSV.foreach(Rails.root.join('test_data/tbl_dict_vendors.txt'), encoding: "ISO-8859-1", headers: vendor_headers, liberal_parsing: true, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  Vendor.new(id: row[:ID], brand_name: row[:vendor]).save!
end

# Create Headers
heading_headers = %i[ID, heading]
CSV.foreach(Rails.root.join('test_data/tbl_dict_headings.txt'), encoding: "ISO-8859-1", headers: heading_headers, col_sep: '|', liberal_parsing: true) do |row|
  next if row[:ID] == 'ID'

  Heading.new(id: row[:ID], label: row[:heading]).save!
end

# Create Subheaders
subheading_headers = %i[ID, subheading]
CSV.foreach(Rails.root.join('test_data/tbl_dict_subheadings.txt'), encoding: "ISO-8859-1", headers: heading_headers, col_sep: '|', liberal_parsing: true) do |row|
  next if row[:ID] == 'ID'

  Subheading.new(id: row[:ID], label: row[:subheading])
end

# Create Databases
database_headers = %i[jhu_id vendor_id db_name status_id url enable_proxy description internal_note popularity_score date_created date_updated]
CSV.foreach(Rails.root.join('test_data/tbl_db_list.txt'), encoding: "ISO-8859-1", headers: database_headers, col_sep: '|', liberal_parsing: true) do |row|
  next if row[0] == 'jhu_id'

  if !Vendor.where(id: row[:vendor_id]).first
    row[:vendor_id] = nil 
  end
  Database.new(vendor_id: row[:vendor_id], name: row[:db_name], url: row[:url], enable_proxy: row[:enable_proxy], description: row[:description], internal_note: row[:internal_note], jhu_id: row[:jhu_id]).save!
end

# Create Datebase Headings
database_heading_headers = %i[ID jhu_id heading_id subheading_id]
CSV.foreach(Rails.root.join('test_data/tbl_db_headings.txt'), encoding: "ISO-8859-1", headers: heading_headers, col_sep: '|', liberal_parsing: true) do |row|
  next if row[:ID] == 'ID'

  Subheading.new(id: row[:ID], jhu_id: row[:jhu_id], heading_id: row[:heading_id], subheading_id: row[:subheading_id], database_id: integer)
end