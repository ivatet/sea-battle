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

ActiveRecord::Schema.define(version: 20161030172110) do

  create_table "battle_configurations", force: :cascade do |t|
    t.string  "configuration_name"
    t.integer "width"
    t.integer "height"
  end

  create_table "battles", force: :cascade do |t|
    t.integer  "battle_configuration_id"
    t.string   "battle_name"
    t.string   "creator_uuid"
    t.string   "next_player_uuid"
    t.integer  "turn_number",             default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "fleet_configurations", force: :cascade do |t|
    t.integer "battle_configuration_id"
    t.integer "ship_length"
    t.integer "ship_cnt"
  end

  create_table "fleets", force: :cascade do |t|
    t.integer  "battle_id"
    t.string   "fleet_name"
    t.string   "player_uuid"
    t.boolean  "is_approved",       default: false
    t.string   "fleet_arrangement"
    t.string   "shot_map"
    t.integer  "ship_cnt",          default: 10
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
