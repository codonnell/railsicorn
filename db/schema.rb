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

ActiveRecord::Schema.define(version: 20170226212340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attacks", force: :cascade do |t|
    t.integer  "torn_id"
    t.datetime "timestamp_started"
    t.datetime "timestamp_ended"
    t.integer  "attacker_id"
    t.integer  "defender_id"
    t.string   "result"
    t.float    "respect_gain"
    t.datetime "timestamp"
    t.index ["attacker_id"], name: "index_attacks_on_attacker_id", using: :btree
    t.index ["defender_id"], name: "index_attacks_on_defender_id", using: :btree
  end

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
    t.index ["player_id"], name: "index_battle_stats_updates_on_player_id", using: :btree
    t.index ["timestamp"], name: "index_battle_stats_updates_on_timestamp", using: :btree
  end

  create_table "factions", force: :cascade do |t|
    t.integer  "torn_id"
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_info_updates", force: :cascade do |t|
    t.datetime "timestamp"
    t.integer  "level"
    t.datetime "last_action"
    t.integer  "player_id"
    t.integer  "awards"
    t.integer  "friends"
    t.integer  "enemies"
    t.integer  "karma"
    t.integer  "forum_posts"
    t.string   "role"
    t.boolean  "donator"
    t.integer  "max_life"
    t.integer  "company_id"
    t.string   "position"
    t.integer  "spouse_id"
    t.integer  "logins"
    t.integer  "activity"
    t.integer  "attacks_won"
    t.integer  "attacks_draw"
    t.integer  "attacks_lost"
    t.integer  "highest_beaten"
    t.integer  "best_kill_streak"
    t.integer  "defends_lost"
    t.integer  "defends_won"
    t.integer  "defends_draw"
    t.integer  "xan_taken"
    t.integer  "ecstasy_taken"
    t.integer  "times_traveled"
    t.bigint   "networth"
    t.integer  "refills"
    t.integer  "stat_enhancers_used"
    t.integer  "medical_items_used"
    t.integer  "weapons_bought"
    t.integer  "bazaar_customers"
    t.integer  "bazaar_sales"
    t.bigint   "bazaar_profit"
    t.integer  "points_bought"
    t.integer  "points_sold"
    t.integer  "items_bought_abroad"
    t.integer  "items_bought"
    t.integer  "trades"
    t.integer  "items_sent"
    t.integer  "auctions_won"
    t.integer  "auctions_sold"
    t.bigint   "money_mugged"
    t.integer  "attacks_stealthed"
    t.integer  "critical_hits"
    t.integer  "respect"
    t.integer  "rounds_fired"
    t.integer  "attacks_ran_away"
    t.integer  "defends_ran_away"
    t.integer  "people_busted"
    t.integer  "failed_busts"
    t.integer  "bails_bought"
    t.integer  "bails_spent"
    t.integer  "viruses_coded"
    t.integer  "city_finds"
    t.integer  "bounties_placed"
    t.integer  "bounties_received"
    t.integer  "bounties_collected"
    t.bigint   "bounty_rewards"
    t.bigint   "bounties_spent"
    t.integer  "revives"
    t.integer  "revives_received"
    t.integer  "trains_received"
    t.integer  "drugs_taken"
    t.integer  "overdoses"
    t.integer  "merits_bought"
    t.integer  "personals_placed"
    t.integer  "classifieds_placed"
    t.integer  "mail_sent"
    t.integer  "friend_mail_sent"
    t.integer  "faction_mail_sent"
    t.integer  "company_mail_sent"
    t.integer  "spouse_mail_sent"
    t.integer  "largest_mug"
    t.integer  "canabis_taken"
    t.integer  "ketamine_taken"
    t.integer  "lsd_taken"
    t.integer  "opium_taken"
    t.integer  "shrooms_taken"
    t.integer  "speed_taken"
    t.integer  "pcp_taken"
    t.integer  "vicodin_taken"
    t.integer  "mechanical_hits"
    t.integer  "artillery_hits"
    t.integer  "clubbed_hits"
    t.integer  "temp_hits"
    t.integer  "machine_gun_hits"
    t.integer  "pistol_hits"
    t.integer  "rifle_hits"
    t.integer  "shotgun_hits"
    t.integer  "smg_hits"
    t.integer  "piercing_hits"
    t.integer  "slashing_hits"
    t.integer  "argentina_travel"
    t.integer  "mexico_travel"
    t.integer  "dubai_travel"
    t.integer  "hawaii_travel"
    t.integer  "japan_travel"
    t.integer  "london_travel"
    t.integer  "south_africa_travel"
    t.integer  "switzerland_travel"
    t.integer  "china_travel"
    t.integer  "canada_travel"
    t.integer  "caymans_travel"
    t.integer  "dump_finds"
    t.integer  "dump_searches"
    t.integer  "items_dumped"
    t.integer  "days_as_donator"
    t.integer  "times_jailed"
    t.integer  "times_hospitalized"
    t.integer  "attacks_assisted"
    t.integer  "blood_withdrawn"
    t.integer  "mission_credits"
    t.integer  "contracts_completed"
    t.integer  "duke_contracts_completed"
    t.integer  "missions_completed"
    t.string   "name"
    t.index ["player_id"], name: "index_player_info_updates_on_player_id", using: :btree
    t.index ["spouse_id"], name: "index_player_info_updates_on_spouse_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "torn_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "faction_id"
    t.datetime "signup"
    t.index ["faction_id"], name: "index_players_on_faction_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.integer  "faction_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "requests_available"
    t.index ["api_key"], name: "index_users_on_api_key", using: :btree
    t.index ["faction_id"], name: "index_users_on_faction_id", using: :btree
  end

  add_foreign_key "attacks", "players", column: "attacker_id"
  add_foreign_key "attacks", "players", column: "defender_id"
  add_foreign_key "battle_stats_updates", "players"
  add_foreign_key "player_info_updates", "players"
  add_foreign_key "player_info_updates", "players", column: "spouse_id"
  add_foreign_key "players", "factions"
  add_foreign_key "players", "users"
  add_foreign_key "users", "factions"
end
