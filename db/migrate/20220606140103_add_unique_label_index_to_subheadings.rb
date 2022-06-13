class AddUniqueLabelIndexToSubheadings < ActiveRecord::Migration[7.0]
  def change
    add_index :subheadings, :label, unique: true
  end
end
