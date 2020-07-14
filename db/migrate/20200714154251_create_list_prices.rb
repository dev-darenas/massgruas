class CreateListPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :list_prices do |t|
      t.integer :flag
      t.integer :waiting_hours_value
      t.integer :kilometer_value
      t.integer :night_surcharge
      t.integer :red_zone_value
      t.integer :holiday_surcharge
      t.references :client, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
