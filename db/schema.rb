# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160928001754) do

  create_table "base_de_respuesta", force: :cascade do |t|
    t.string   "contestacion_type"
    t.integer  "contestacion_id"
    t.text     "valor",                      limit: 10000
    t.string   "indice_de_creacion"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "categorias_en_preguntum_id"
  end

  add_index "base_de_respuesta", ["contestacion_id"], name: "index_base_de_respuesta_on_contestacion_id"
  add_index "base_de_respuesta", ["indice_de_creacion"], name: "index_base_de_respuesta_on_indice_de_creacion"

  create_table "categorias_en_pregunta", force: :cascade do |t|
    t.integer  "pregunta_id"
    t.string   "titulo"
    t.integer  "valor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cuestionarios", force: :cascade do |t|
    t.integer  "creado_por_id"
    t.string   "titulo"
    t.text     "instrucciones"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.boolean  "compartir",     default: true
    t.boolean  "paginar",       default: false
    t.boolean  "privado"
  end

  create_table "indice_de_creacions", force: :cascade do |t|
    t.string   "idx"
    t.boolean  "web"
    t.string   "pass_mobile"
    t.string   "lat"
    t.string   "long"
    t.integer  "cuestionario_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "indice_de_creacions", ["idx"], name: "index_indice_de_creacions_on_idx"
  add_index "indice_de_creacions", ["pass_mobile"], name: "index_indice_de_creacions_on_pass_mobile"

  create_table "pase_dinamicos", force: :cascade do |t|
    t.integer  "de_a"
    t.integer  "de_b"
    t.integer  "pase"
    t.integer  "pregunta_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pregunta", force: :cascade do |t|
    t.string   "titulo"
    t.string   "tipo"
    t.string   "descripccion"
    t.integer  "cuestionario_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "imagen"
    t.string   "valor"
    t.integer  "de_a"
    t.integer  "de_b"
    t.boolean  "emogi",           default: false
    t.string   "coleccion_emogi"
    t.integer  "pase"
  end

  create_table "respuesta", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "pregunta_id"
    t.string   "valor"
    t.boolean  "checkflag"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.decimal  "respuesta",   default: 0.0
    t.decimal  "pase",        default: 0.0
  end

  create_table "token_de_descargas", force: :cascade do |t|
    t.integer  "cuestionario_id"
    t.string   "token"
    t.boolean  "uso"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
  end

  add_index "token_de_descargas", ["token"], name: "index_token_de_descargas_on_token"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "avanzada",               default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.boolean  "free",                   default: true
    t.string   "validation_by_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "volores_multiples_to_respuesta", force: :cascade do |t|
    t.integer  "respuesta_id"
    t.string   "nombre_del_valor"
    t.integer  "cuantificador_del_valor"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "wiki_users", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "email"
    t.string   "telefono"
    t.text     "direccion"
    t.string   "puesto"
    t.string   "identificacion"
    t.string   "numero_identificacion"
    t.string   "rol_en_el_preoceso"
    t.string   "curp"
    t.string   "compania_con_registro"
    t.string   "codigo_de_aprovacion"
    t.string   "codigo_para_actividad"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
