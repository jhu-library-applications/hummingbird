class AddMulticolumnIndexToDatabaseHeadingsJhuId < ActiveRecord::Migration[7.0]
  def change
    add_index :database_headings, [:heading_id, :subheading_id, :jhu_id], unique: true, name: 'multicolumn_jhu_id_index'
  end
end
