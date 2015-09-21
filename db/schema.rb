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

ActiveRecord::Schema.define(version: 20150921091857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "comments", force: :cascade do |t|
    t.text     "text",             null: false
    t.integer  "user_id",          null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "conversation_participants", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "conversation_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "key",        null: false
  end

  create_table "friendship_invites", force: :cascade do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "friend_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_ownerships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "game_id",    null: false
    t.string   "nickname",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_rules", force: :cascade do |t|
    t.integer  "game_id",                 null: false
    t.string   "name",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.hstore   "properties", default: {}, null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "conversation_id", null: false
    t.text     "text",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "type",                       null: false
    t.boolean  "checked",    default: false, null: false
    t.hstore   "properties", default: {},    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "team_membership_propositions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.string   "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "team_id",                    null: false
    t.boolean  "captain",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.string   "tag"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "founder_id",  null: false
    t.string   "image_url"
  end

  create_table "tournament_participants", force: :cascade do |t|
    t.integer  "tournament_team_id", null: false
    t.integer  "user_id",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "tournament_setups", force: :cascade do |t|
    t.integer  "game_id",                          null: false
    t.integer  "minimal_number_of_teams_to_start", null: false
    t.integer  "maximal_number_of_teams",          null: false
    t.datetime "sign_up_start_at",                 null: false
    t.datetime "sign_up_end_at",                   null: false
    t.integer  "number_of_participants_per_team",  null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "tournament_teams", force: :cascade do |t|
    t.integer  "tournament_setup_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname",                                      null: false
    t.integer  "flags_mask",             limit: 8, default: 0,  null: false
    t.text     "description"
    t.string   "sex"
    t.integer  "age"
    t.string   "nationality"
    t.string   "image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
