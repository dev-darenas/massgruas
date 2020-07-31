class EditColumnEndTimeInTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :hora_final, :time
    add_column :transactions, :hora_final, :datetime
  end
end
