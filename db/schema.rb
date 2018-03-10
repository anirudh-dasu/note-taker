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

ActiveRecord::Schema.define(version: 20_180_310_070_742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "url"
    t.bigint "user_id"
    t.string "kind"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notes_tags", id: false, force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_notes_tags_on_note_id"
    t.index ["tag_id"], name: "index_notes_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tags_users_on_tag_id"
    t.index ["user_id"], name: "index_tags_users_on_user_id"
  end

  create_table "user_devices", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "device_id"
    t.string "device_type"
    t.string "jwt"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "notes", "users"
  add_foreign_key "notes_tags", "notes"
  add_foreign_key "notes_tags", "tags"
  add_foreign_key "tags_users", "tags"
  add_foreign_key "tags_users", "users"
  add_foreign_key "user_devices", "users"
end
