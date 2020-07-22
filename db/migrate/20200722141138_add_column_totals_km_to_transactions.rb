class AddColumnTotalsKmToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :total_normal_zone, :float
    add_column :transactions, :total_red_zone, :float
  end
end
