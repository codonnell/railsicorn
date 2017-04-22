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

ActiveRecord::Schema.define(version: 20170422172932) do

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
    t.index ["timestamp"], name: "index_attacks_on_timestamp", using: :btree
    t.index ["torn_id"], name: "index_attacks_on_torn_id", unique: true, using: :btree
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
    t.index ["torn_id"], name: "index_factions_on_torn_id", unique: true, using: :btree
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
    t.integer  "logins",                   default: 0
    t.integer  "activity",                 default: 0
    t.integer  "attacks_won",              default: 0
    t.integer  "attacks_draw",             default: 0
    t.integer  "attacks_lost",             default: 0
    t.integer  "highest_beaten",           default: 0
    t.integer  "best_kill_streak",         default: 0
    t.integer  "defends_lost",             default: 0
    t.integer  "defends_won",              default: 0
    t.integer  "defends_draw",             default: 0
    t.integer  "xanax_taken",              default: 0
    t.integer  "ecstasy_taken",            default: 0
    t.integer  "times_traveled",           default: 0
    t.bigint   "networth",                 default: 0
    t.integer  "refills",                  default: 0
    t.integer  "stat_enhancers_used",      default: 0
    t.integer  "medical_items_used",       default: 0
    t.integer  "weapons_bought",           default: 0
    t.integer  "bazaar_customers",         default: 0
    t.integer  "bazaar_sales",             default: 0
    t.bigint   "bazaar_profit",            default: 0
    t.integer  "points_bought",            default: 0
    t.integer  "points_sold",              default: 0
    t.integer  "items_bought_abroad",      default: 0
    t.integer  "items_bought",             default: 0
    t.integer  "trades",                   default: 0
    t.integer  "items_sent",               default: 0
    t.integer  "auctions_won",             default: 0
    t.integer  "auctions_sold",            default: 0
    t.bigint   "money_mugged",             default: 0
    t.integer  "attacks_stealthed",        default: 0
    t.integer  "critical_hits",            default: 0
    t.integer  "respect",                  default: 0
    t.integer  "rounds_fired",             default: 0
    t.integer  "attacks_ran_away",         default: 0
    t.integer  "defends_ran_away",         default: 0
    t.integer  "people_busted",            default: 0
    t.integer  "failed_busts",             default: 0
    t.integer  "bails_bought",             default: 0
    t.bigint   "bails_spent",              default: 0
    t.integer  "viruses_coded",            default: 0
    t.integer  "city_finds",               default: 0
    t.integer  "bounties_placed",          default: 0
    t.integer  "bounties_received",        default: 0
    t.integer  "bounties_collected",       default: 0
    t.bigint   "bounty_rewards",           default: 0
    t.bigint   "bounties_spent",           default: 0
    t.integer  "revives",                  default: 0
    t.integer  "revives_received",         default: 0
    t.integer  "trains_received",          default: 0
    t.integer  "drugs_taken",              default: 0
    t.integer  "overdoses",                default: 0
    t.integer  "merits_bought",            default: 0
    t.integer  "personals_placed",         default: 0
    t.integer  "classifieds_placed",       default: 0
    t.integer  "mail_sent",                default: 0
    t.integer  "friend_mail_sent",         default: 0
    t.integer  "faction_mail_sent",        default: 0
    t.integer  "company_mail_sent",        default: 0
    t.integer  "spouse_mail_sent",         default: 0
    t.bigint   "largest_mug",              default: 0
    t.integer  "canabis_taken",            default: 0
    t.integer  "ketamine_taken",           default: 0
    t.integer  "lsd_taken",                default: 0
    t.integer  "opium_taken",              default: 0
    t.integer  "shrooms_taken",            default: 0
    t.integer  "speed_taken",              default: 0
    t.integer  "pcp_taken",                default: 0
    t.integer  "vicodin_taken",            default: 0
    t.integer  "mechanical_hits",          default: 0
    t.integer  "artillery_hits",           default: 0
    t.integer  "clubbed_hits",             default: 0
    t.integer  "temp_hits",                default: 0
    t.integer  "machine_gun_hits",         default: 0
    t.integer  "pistol_hits",              default: 0
    t.integer  "rifle_hits",               default: 0
    t.integer  "shotgun_hits",             default: 0
    t.integer  "smg_hits",                 default: 0
    t.integer  "piercing_hits",            default: 0
    t.integer  "slashing_hits",            default: 0
    t.integer  "argentina_travel",         default: 0
    t.integer  "mexico_travel",            default: 0
    t.integer  "dubai_travel",             default: 0
    t.integer  "hawaii_travel",            default: 0
    t.integer  "japan_travel",             default: 0
    t.integer  "london_travel",            default: 0
    t.integer  "south_africa_travel",      default: 0
    t.integer  "switzerland_travel",       default: 0
    t.integer  "china_travel",             default: 0
    t.integer  "canada_travel",            default: 0
    t.integer  "caymans_travel",           default: 0
    t.integer  "dump_finds",               default: 0
    t.integer  "dump_searches",            default: 0
    t.integer  "items_dumped",             default: 0
    t.integer  "days_as_donator",          default: 0
    t.integer  "times_jailed",             default: 0
    t.integer  "times_hospitalized",       default: 0
    t.integer  "attacks_assisted",         default: 0
    t.integer  "blood_withdrawn",          default: 0
    t.integer  "mission_credits",          default: 0
    t.integer  "contracts_completed",      default: 0
    t.integer  "duke_contracts_completed", default: 0
    t.integer  "missions_completed",       default: 0
    t.string   "name"
    t.integer  "medical_items_stolen",     default: 0
    t.integer  "spies_done",               default: 0
    t.integer  "best_damage",              default: 0
    t.integer  "kill_streak",              default: 0
    t.integer  "one_hit_kills",            default: 0
    t.bigint   "money_invested",           default: 0
    t.bigint   "invested_profit",          default: 0
    t.integer  "attack_misses",            default: 0
    t.bigint   "attack_damage",            default: 0
    t.integer  "attack_hits",              default: 0
    t.index ["player_id"], name: "index_player_info_updates_on_player_id", using: :btree
    t.index ["spouse_id"], name: "index_player_info_updates_on_spouse_id", using: :btree
    t.index ["timestamp"], name: "index_player_info_updates_on_timestamp", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "torn_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "faction_id"
    t.datetime "signup"
    t.float    "least_stats_beaten_by"
    t.float    "most_stats_defended_against"
    t.index ["faction_id"], name: "index_players_on_faction_id", using: :btree
    t.index ["torn_id"], name: "index_players_on_torn_id", unique: true, using: :btree
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
