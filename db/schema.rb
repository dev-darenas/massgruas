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

ActiveRecord::Schema.define(version: 2020_06_19_143256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "razon_social"
    t.string "regimen"
    t.string "actividad_comercial"
    t.string "nombre"
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

  create_table "pictures", force: :cascade do |t|
    t.string "image"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "enterprise_id"
    t.string "email", default: "", null: false
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
  add_foreign_key "vehicles", "enterprises"
end
