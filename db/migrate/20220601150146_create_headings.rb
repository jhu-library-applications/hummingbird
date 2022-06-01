class CreateHeadings < ActiveRecord::Migration[7.0]
  def change
    create_table :headings do |t|
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
