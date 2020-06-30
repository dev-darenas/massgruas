class CreateTechnicals < ActiveRecord::Migration[6.0]
  def change
    create_table :technicals do |t|
      t.string :nombre
      t.string :cedula
      t.string :cargo
      t.string :direccion
      t.string :telefono1
      t.string :telefono2
      t.date :fecha_nacimiento
      t.string :estado_civil
      t.string :conyuge
      t.string :hijos
      t.string :n_licencia
      t.string :categoria
      t.string :eps
      t.string :arl
      t.date :vinculacion
      t.date :retiro
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
