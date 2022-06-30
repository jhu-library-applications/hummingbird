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
Database.destroy_all
# Heading.destroy_all
# Subheading.destroy_all
Vendor.destroy_all
# Database.destroy_all

# Create vendors

vendor_headers = %i[ID vendor]
CSV.foreach(Rails.root.join('test_data/tbl_dict_vendors.txt'), encoding: "ISO-8859-1", headers: vendor_headers, liberal_parsing: true) do |row|
  next if row[:ID] == 'ID'
  # row[:vendor]? vendor_name_uniq = row[:vendor] : vendor_name_uniq = "no vendor name"

  # if Vendor.where(brand_name: row[:vendor]).first
  #   vendor_name_uniq = vendor_name_uniq + " (dup)"
  # end

  Vendor.new(id: row[:ID], brand_name: row[:vendor]).save!
end

# database_headers = %i[jhu_id vendor_id db_name status_id url enable_proxy description internal_note popularity_score date_created date_updated]
CSV.foreach(Rails.root.join('test_data/tbl_db_list.txt'), encoding: "ISO-8859-1", headers: true, col_sep: '|', liberal_parsing: true) do |row|
  next if row[:jhu_id] == 'jhu_id'
  puts row
  Database.new(vendor_id: row[:vendor_id], name: row[:db_name], url: row[:url], enable_proxy: row[:enable_proxy], description: row[:description], internal_note: row[:internal_note], jhu_id: row[:jhu_id]).save!
end