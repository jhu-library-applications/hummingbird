class ChangeVendorToCaseInsen < ActiveRecord::Migration[7.0]
  def up
    enable_extension :citext
    change_column :vendors, :brand_name, :citext
  end
  
  def down
    change_column :vendors, :brand_name, :text
    disable_extension :citext
  end
end
