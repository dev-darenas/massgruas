class AddColumnWaitingHoursValueToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :waiting_hours_value, :integer
    add_column :transactions, :total_waiting_hours, :float
  end
end
