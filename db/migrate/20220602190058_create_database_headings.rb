class CreateDatabaseHeadings < ActiveRecord::Migration[7.0]
  def change
    create_table :database_headings do |t|
      t.string :jhu_id
      t.references :heading, null: false, foreign_key: true
      t.references :subheading, null: false, foreign_key: true
      t.references :database, null: false, foreign_key: true
      t.timestamps
    end
  end
end
