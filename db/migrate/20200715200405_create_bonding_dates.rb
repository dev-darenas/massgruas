class CreateBondingDates < ActiveRecord::Migration[6.0]
  def change
    create_table :bonding_dates do |t|
      t.date :entry_date
      t.date :departure_date
      t.string :observation
      t.references :technical, null: false, foreign_key: true

      t.timestamps
    end
  end
end
