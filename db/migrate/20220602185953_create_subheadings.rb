class CreateSubheadings < ActiveRecord::Migration[7.0]
  def change
    create_table :subheadings do |t|
      t.string :label

      t.timestamps
    end
  end
end
