class AddUniqueLabelIndexToHeadings < ActiveRecord::Migration[7.0]
  def change
    add_index :headings, :label, unique: true
  end
end
