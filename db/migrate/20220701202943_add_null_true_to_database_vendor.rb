class AddNullTrueToDatabaseVendor < ActiveRecord::Migration[7.0]
  def up
    change_table :vendors do |t|
      t.references :vendor, null: true, foreign_key: true
    end
  end

  def down
    change_table :vendors do |t|
      t.references :vendor, null: true, foreign_key: true
    end
  end
end
