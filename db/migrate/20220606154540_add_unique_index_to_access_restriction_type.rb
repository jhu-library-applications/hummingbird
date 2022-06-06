class AddUniqueIndexToAccessRestrictionType < ActiveRecord::Migration[7.0]
  def change
    add_index :access_restriction_types, :type_label, unique: true
  end
end
