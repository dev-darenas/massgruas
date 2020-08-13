class AddDeletedAtToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :deleted_at, :datetime
    add_index :vehicles, :deleted_at
  end
end
