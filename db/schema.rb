# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2021_02_24_032349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "jti", null: false
    t.string "aud", null: false
    t.datetime "exp", precision: nil, null: false
    t.string "remote_ip"
    t.string "os_data"
    t.string "browser_data"
    t.string "device_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "username", default: "", null: false
    t.string "display_name", default: "", null: false
    t.string "slug", default: "", null: false
    t.string "address", default: "", null: false
    t.string "city", default: "", null: false
    t.string "postcode", default: "", null: false
    t.string "country", default: "", null: false
    t.string "phone", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_users_on_display_name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
end
