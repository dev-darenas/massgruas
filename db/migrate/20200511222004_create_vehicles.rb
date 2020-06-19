class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :placa
      t.string :licencia
      t.string :clase
      t.string :marca
      t.string :tipo
      t.string :linea
      t.string :servicio
      t.string :combustible
      t.string :color
      t.string :modelo
      t.string :motor
      t.string :chasis
      t.string :serie
      t.date :fecha_de_compra
      t.string :contrato
      t.string :n_soat
      t.date :vencimiento_soat
      t.string :n_rtm
      t.date :vencimiento_rtm
      t.string :km_cambio_aceite
      t.string :km_proximocambio
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
