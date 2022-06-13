class AddMulticolumnIndexToDatabaseHeadings < ActiveRecord::Migration[7.0]
  def change
    add_index :database_headings, [:heading_id, :subheading_id, :jhu_id, :database_id], unique: true, name: 'multicolumn_db_heading_index'
  end
end
