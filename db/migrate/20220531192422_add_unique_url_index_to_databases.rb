class AddUniqueUrlIndexToDatabases < ActiveRecord::Migration[7.0]
  def change
    add_index :databases, :url, unique: true
  end
end
