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

ActiveRecord::Schema.define(version: 20140204162544) do

  create_table "contribucions", force: true do |t|
    t.integer  "practica_id"
    t.integer  "objetivo_id"
    t.integer  "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "objetivos", force: true do |t|
    t.string   "name"
    t.boolean  "sat_client"
    t.boolean  "equipo"
    t.boolean  "productivity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practicas", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "agile_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "effort"
    t.text     "description"
  end

  create_table "user_practicas", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "agile_method"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "practica_id"
    t.integer  "legacy_position"
    t.text     "comment"
    t.integer  "effort"
    t.integer  "range"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
