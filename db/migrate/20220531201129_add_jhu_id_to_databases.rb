class AddJhuIdToDatabases < ActiveRecord::Migration[7.0]
  def change
    add_column :databases, :jhu_id, :string
    add_index :databases, :jhu_id, unique: true
  end
end
