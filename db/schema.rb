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

ActiveRecord::Schema[7.1].define(version: 2025_06_02_140728) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.string "first_name"
    t.bigint "mother_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mother_id"], name: "index_children_on_mother_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "speciality"
    t.datetime "availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string "type"
    t.bigint "mother_id", null: false
    t.bigint "child_id", null: false
    t.datetime "time_left", precision: nil
    t.datetime "time_right", precision: nil
    t.float "quantity_left"
    t.float "quantity_right"
    t.string "mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_feeds_on_child_id"
    t.index ["mother_id"], name: "index_feeds_on_mother_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "mother_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_messages_on_doctor_id"
    t.index ["mother_id"], name: "index_messages_on_mother_id"
  end

  create_table "mothers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.integer "time_between_feed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.float "rating"
    t.bigint "safe_place_id", null: false
    t.bigint "mother_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mother_id"], name: "index_reviews_on_mother_id"
    t.index ["safe_place_id"], name: "index_reviews_on_safe_place_id"
  end

  create_table "safe_places", force: :cascade do |t|
    t.string "name"
    t.string "adress"
    t.text "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "children", "mothers"
  add_foreign_key "feeds", "children"
  add_foreign_key "feeds", "mothers"
  add_foreign_key "messages", "doctors"
  add_foreign_key "messages", "mothers"
  add_foreign_key "reviews", "mothers"
  add_foreign_key "reviews", "safe_places"
end
