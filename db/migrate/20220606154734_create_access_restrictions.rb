class CreateAccessRestrictions < ActiveRecord::Migration[7.0]
  def change
    create_table :access_restrictions do |t|
      t.string :jhu_id
      t.references :access_restriction_type, null: false, foreign_key: true
      t.references :database, null: false, foreign_key: true
      t.text :note
      t.string :private_url

      t.timestamps
    end
  end
end
