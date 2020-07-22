class AddColumnPricedToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :priced, :float
  end
end
