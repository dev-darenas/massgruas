json.extract! vehicle, :placa, :licencia, :clase, :marca, :tipo, :linea, :servicio, :combustible,
              :color, :modelo, :motor, :chasis, :serie, :fecha_de_compra, :contrato, :n_soat,
              :vencimiento_soat, :n_rtm, :vencimiento_rtm, :km_cambio_aceite,
              :km_proximocambio, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
