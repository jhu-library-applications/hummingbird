class AddForeignKeyToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :headings, :heading_id, :integer
    add_column :subheadings, :subheading_id, :integer
    add_column :database_headings, :database_heading_id, :integer
    add_column :access_restriction_types, :access_restriction_type_id, :integer
    add_column :vendors, :vendor_gid, :integer
  end
end
