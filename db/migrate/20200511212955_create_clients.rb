class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :razon_social
      t.string :regimen
      t.string :actividad_comercial
      t.string :nombre
      t.string :direccion
      t.string :ciudad
      t.string :telefono
      t.string :email
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
