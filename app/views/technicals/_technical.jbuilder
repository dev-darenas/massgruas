json.extract! technical,:nombre, :cedula, :cargo, :direccion, :telefono1, :telefono2,
              :fecha_nacimiento, :estado_civil, :conyuge, :hijos, :n_licencia,
              :categoria, :eps, :arl, :vinculacion, :retiro
json.url technical_url(technical, format: :json)
