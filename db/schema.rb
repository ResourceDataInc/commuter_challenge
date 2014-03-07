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

ActiveRecord::Schema.define(version: 20140227024246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brackets", force: true do |t|
    t.string   "name"
    t.integer  "lower_limit"
    t.integer  "upper_limit"
    t.integer  "competition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "competitions", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_on"
    t.date     "end_on"
    t.integer  "owner_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "competitors_count", default: 0
  end

  add_index "competitions", ["owner_id"], name: "index_competitions_on_owner_id", using: :btree

  create_table "competitors", force: true do |t|
    t.integer  "competition_id"
    t.integer  "team_id"
    t.boolean  "approved"
    t.datetime "approved_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "competitors", ["competition_id"], name: "index_competitors_on_competition_id", using: :btree
  add_index "competitors", ["team_id"], name: "index_competitors_on_team_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "approved_at"
    t.integer  "ride_count",  default: 0
  end

  add_index "memberships", ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true, using: :btree

  create_table "rides", force: true do |t|
    t.date     "date"
    t.decimal  "bike_distance"
    t.text     "description"
    t.boolean  "is_round_trip"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "rider_id"
    t.decimal  "bus_distance"
    t.decimal  "walk_distance"
    t.boolean  "work_trip"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "captain_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "business_size"
    t.integer  "memberships_count", default: 0
  end

  add_index "teams", ["captain_id"], name: "index_teams_on_captain_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
