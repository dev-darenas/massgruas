class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :enterprise, null: false, foreign_key: true
      t.string :status,                         null: false, default: "Open"
      t.integer :service_number
      t.datetime :fecha
      t.string :orden_Trabajo
      t.string :remision
      t.string :factura
      t.time :hora_llegada
      t.time :hora_final
      t.string :response_time
      t.references :client, null: false, foreign_key: true
      t.string :cuenta
      t.string :expediente
      t.string :placa
      t.string :tarea
      t.string :origen
      t.float  :lat
      t.float  :lng
      t.string :destino
      t.float  :latb
      t.float  :lngb
      t.string :asegurado
      t.string :direccion
      t.string :telefono
      t.references :technical, null: false, foreign_key:true
      t.references :vehicle, null: false, foreign_key:true
      t.float :total_km
      t.float :km_zona_normal
      t.float :km_zona_roja
      t.float :banderazo
      t.float :valor_km_zona_n
      t.float :valor_km_zona_r
      t.float :horas_de_espera
      t.float :rango_nocturno
      t.float :recargo_festivo
      t.float :valor_servicio
      t.string :operador
      t.float :celula_costo
      t.datetime :fecha_de_cierre
      t.float :descuento
      t.float :pago_total
      t.float :porcentaje_tecnico
      t.float :pago_tecnico
      t.float :combustible
      t.float :peajes
      t.float :gasto_viaje
      t.float :gastos
      t.float :ganancias
      t.timestamps
    end
  end
end
