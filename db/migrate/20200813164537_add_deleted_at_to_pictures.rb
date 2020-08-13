class AddDeletedAtToPictures < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :deleted_at, :datetime
    add_index :pictures, :deleted_at
  end
end
