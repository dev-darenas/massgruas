class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :placa
      t.string :licencia
      t.string :marca
      t.string :color
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
