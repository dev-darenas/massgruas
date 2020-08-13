class AddDeletedAtToTechnicals < ActiveRecord::Migration[6.0]
  def change
    add_column :technicals, :deleted_at, :datetime
    add_index :technicals, :deleted_at
  end
end
