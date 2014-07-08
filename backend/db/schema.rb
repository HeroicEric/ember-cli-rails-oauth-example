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

ActiveRecord::Schema.define(version: 20140706143627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "access_token", null: false
    t.datetime "expires_at",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",   null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
