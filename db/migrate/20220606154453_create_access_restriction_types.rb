class CreateAccessRestrictionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :access_restriction_types do |t|
      t.string :type_label
      t.text :note
      t.boolean :private

      t.timestamps
    end
  end
end
