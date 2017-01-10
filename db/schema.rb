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

ActiveRecord::Schema.define(version: 20170108183952) do

  create_table "battle_stats_updates", force: :cascade do |t|
    t.datetime "timestamp"
    t.float    "strength"
    t.float    "dexterity"
    t.float    "speed"
    t.float    "defense"
    t.float    "strength_modifier"
    t.float    "dexterity_modifier"
    t.float    "speed_modifier"
    t.float    "defense_modifier"
    t.integer  "player_id"
    t.index ["player_id"], name: "index_battle_stats_updates_on_player_id"
    t.index ["timestamp"], name: "index_battle_stats_updates_on_timestamp"
  end

  create_table "factions", force: :cascade do |t|
    t.integer  "torn_id"
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "torn_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "faction_id"
    t.string   "name"
    t.datetime "signup"
    t.index ["faction_id"], name: "index_players_on_faction_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.integer  "faction_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "requests_available"
    t.index ["api_key"], name: "index_users_on_api_key"
    t.index ["faction_id"], name: "index_users_on_faction_id"
  end

end
