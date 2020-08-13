class AddDeletedAtToListPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :list_prices, :deleted_at, :datetime
    add_index :list_prices, :deleted_at
  end
end
