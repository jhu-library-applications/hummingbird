class AddUniqueNameIndexToDatabases < ActiveRecord::Migration[7.0]
  def change
    add_index :databases, :name, unique: true
  end
end
