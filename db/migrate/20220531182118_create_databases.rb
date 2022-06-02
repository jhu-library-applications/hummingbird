class CreateDatabases < ActiveRecord::Migration[7.0]
  def change
    create_table :databases do |t|
      t.references :vendor, null: false, foreign_key: true
      t.text :name
      t.text :url
      t.boolean :enable_proxy
      t.text :description
      t.text :internal_note

      t.timestamps
    end
  end
end
