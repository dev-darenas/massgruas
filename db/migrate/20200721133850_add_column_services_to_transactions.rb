class AddColumnServicesToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :service, null: false, foreign_key: true
  end
end
