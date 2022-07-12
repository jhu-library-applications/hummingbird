class AddUniqueIndexToAccessRestrictionPrivateUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :access_restrictions, :private_url, unique: true
  end
end
