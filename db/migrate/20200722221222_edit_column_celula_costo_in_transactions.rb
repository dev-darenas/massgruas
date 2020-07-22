class EditColumnCelulaCostoInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :celula_costo, :string
  end
end
