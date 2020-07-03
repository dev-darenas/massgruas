# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_01_175351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "razon_social"
    t.string "regimen"
    t.string "actividad_comercial"
    t.string "nombre"
    t.string "identificacion"
    t.string "direccion"
    t.string "ciudad"
    t.string "telefono"
    t.string "email"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_clients_on_enterprise_id"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "observations", force: :cascade do |t|
    t.text "description"
    t.bigint "user_id", null: false
    t.string "observable_type", null: false
    t.bigint "observable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["observable_type", "observable_id"], name: "index_observations_on_observable_type_and_observable_id"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "image"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "technicals", force: :cascade do |t|
    t.string "nombre"
    t.string "cedula"
    t.string "cargo"
    t.string "direccion"
    t.string "telefono1"
    t.string "telefono2"
    t.date "fecha_nacimiento"
    t.string "estado_civil"
    t.string "conyuge"
    t.string "hijos"
    t.string "n_licencia"
    t.string "categoria"
    t.string "eps"
    t.string "arl"
    t.date "vinculacion"
    t.date "retiro"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_technicals_on_enterprise_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.string "status", default: "Open", null: false
    t.datetime "fecha"
    t.string "orden_Trabajo"
    t.string "remision"
    t.string "factura"
    t.time "hora_llegada"
    t.time "hora_final"
    t.bigint "client_id", null: false
    t.string "cuenta"
    t.string "expediente"
    t.string "placa"
    t.string "tarea"
    t.string "origen"
    t.string "destino"
    t.string "asegurado"
    t.string "direccion"
    t.string "telefono"
    t.bigint "technical_id", null: false
    t.bigint "vehicle_id", null: false
    t.float "total_km"
    t.float "km_zona_normal"
    t.float "km_zona_roja"
    t.float "banderazo"
    t.float "valor_km_zona_n"
    t.float "valor_km_zona_r"
    t.float "horas_de_espera"
    t.float "rango_nocturno"
    t.float "recargo_festivo"
    t.float "valor_servicio"
    t.string "operador"
    t.float "celula_costo"
    t.datetime "fecha_de_cierre"
    t.float "descuento"
    t.float "pago_total"
    t.float "porcentaje_tecnico"
    t.float "pago_tecnico"
    t.float "combustible"
    t.float "peajes"
    t.float "gasto_viaje"
    t.float "gastos"
    t.float "ganancias"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["enterprise_id"], name: "index_transactions_on_enterprise_id"
    t.index ["technical_id"], name: "index_transactions_on_technical_id"
    t.index ["vehicle_id"], name: "index_transactions_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "enterprise_id"
    t.string "fullname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "rol", default: "Admin", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "placa"
    t.string "licencia"
    t.string "clase"
    t.string "marca"
    t.string "tipo"
    t.string "linea"
    t.string "servicio"
    t.string "combustible"
    t.string "color"
    t.string "modelo"
    t.string "motor"
    t.string "chasis"
    t.string "serie"
    t.date "fecha_de_compra"
    t.string "contrato"
    t.string "n_soat"
    t.date "vencimiento_soat"
    t.string "n_rtm"
    t.date "vencimiento_rtm"
    t.string "km_cambio_aceite"
    t.string "km_proximocambio"
    t.bigint "enterprise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enterprise_id"], name: "index_vehicles_on_enterprise_id"
  end

  add_foreign_key "clients", "enterprises"
  add_foreign_key "observations", "users"
  add_foreign_key "technicals", "enterprises"
  add_foreign_key "transactions", "clients"
  add_foreign_key "transactions", "enterprises"
  add_foreign_key "transactions", "technicals"
  add_foreign_key "transactions", "vehicles"
  add_foreign_key "vehicles", "enterprises"
end
