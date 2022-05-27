class AddUniqueIndexToVendors < ActiveRecord::Migration[7.0]
  def change
    add_index :vendors, :brand_name, unique: true
  end
end
