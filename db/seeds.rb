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

Database.destroy_all
Vendor.destroy_all
Heading.destroy_all
Subheading.destroy_all
DatabaseHeading.destroy_all
AccessRestriction.destroy_all

# Create vendors
vendor_headers = %i[ID vendor]
CSV.foreach(Rails.root.join('test_data/tbl_dict_vendors.txt'), encoding: "ISO-8859-1", headers: vendor_headers, liberal_parsing: true, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  Vendor.new(vendor_gid: row[:ID], brand_name: row[:vendor]).save!
end

# Create Headers
heading_headers = %i[ID, heading]
CSV.foreach(Rails.root.join('test_data/tbl_dict_headings.txt'), encoding: "ISO-8859-1", headers: heading_headers, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  Heading.new(heading_id: row[0], label: row[:heading]).save!
end

# Create Subheaders
subheading_headers = %i[ID, subheading]
CSV.foreach(Rails.root.join('test_data/tbl_dict_subheadings.txt'), encoding: "ISO-8859-1", headers: subheading_headers, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  Subheading.new(subheading_id: row[0], label: row[:subheading]).save!
end

# Create Databases
database_headers = %i[jhu_id vendor_id db_name status_id url enable_proxy description internal_note popularity_score date_created date_updated]
CSV.foreach(Rails.root.join('test_data/tbl_db_list.txt'), encoding: "ISO-8859-1", headers: database_headers, col_sep: '|') do |row|
  next if row[0] == 'jhu_id'

  if !Vendor.where(vendor_gid: row[:vendor_id]).first
    row[:vendor_id] = nil
  end
  Database.new(vendor_id: Vendor.where(vendor_gid: row[:vendor_id])&.first&.id, name: row[:db_name], url: row[:url], enable_proxy: row[:enable_proxy], description: row[:description], internal_note: row[:internal_note], jhu_id: row[:jhu_id]).save!
end

# Create Datebase Headings
database_heading_headers = %i[ID jhu_id heading_id subheading_id]
CSV.foreach(Rails.root.join('test_data/tbl_db_headings.txt'), encoding: "ISO-8859-1", headers: database_heading_headers, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  DatabaseHeading.new(database_heading_id: row[0], jhu_id: row[:jhu_id], heading_id: Heading.all.where(heading_id: row[:heading_id]).first.id,
    subheading_id: Subheading.all.where(subheading_id: row[:subheading_id]).first.id,
    database_id: Database.all.where(jhu_id: row[:jhu_id]).first.id).save!
end

# Create Access Restriction Types
access_restriction_type_headers = %i[ID restrict_type restrict_note_default private]
CSV.foreach(Rails.root.join('test_data/tbl_dict_access_restrictions.txt'), encoding: "ISO-8859-1", headers: access_restriction_type_headers, col_sep: '|') do |row|
  next if row[:ID] == 'ID'

  AccessRestrictionType.new(access_restriction_type_id: row[0], type_label: row[:restrict_type], note: row[:restrict_note_default], private: row[:private]).save!
end

# Create Access Restrictions
access_restriction_headers = %i[jhu_id restrict_type_id restrict_note private_url]
CSV.foreach(Rails.root.join('test_data/tbl_db_access_restrictions.txt'), encoding: "ISO-8859-1", headers: access_restriction_headers, col_sep: '|') do |row|
  next if row[:jhu_id] == 'jhu_id'
  puts Database.all.where(jhu_id: row[0])&.first&.id
  AccessRestriction.new(jhu_id: row[0], access_restriction_type_id: AccessRestrictionType.all.where(access_restriction_type_id: row[:restrict_type_id])&.first&.id, database_id: Database.all.where(jhu_id: row[:jhu_id])&.first&.id, note: row[:restrict_note], private_url: row[:private_url]).save!
end