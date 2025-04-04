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

ActiveRecord::Schema[8.0].define(version: 2025_04_03_171255) do
  create_table "claims", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "found_item_id", null: false
    t.boolean "proof_provided"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["found_item_id"], name: "index_claims_on_found_item_id"
    t.index ["user_id"], name: "index_claims_on_user_id"
  end

  create_table "found_items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "location"
    t.string "category"
    t.integer "user_id", null: false
    t.boolean "claimed"
    t.boolean "reported"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_found_items_on_user_id"
  end

  create_table "lost_items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "location"
    t.string "category"
    t.integer "user_id", null: false
    t.boolean "reported"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "lost_date"
    t.index ["user_id"], name: "index_lost_items_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id"
    t.string "post_type"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.boolean "flagged"
    t.integer "report_count"
    t.boolean "deactivated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "encrypted_password"
    t.string "verification_code"
    t.datetime "code_sent_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "claims", "found_items"
  add_foreign_key "claims", "users"
  add_foreign_key "found_items", "users"
  add_foreign_key "lost_items", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "reports", "users"
end
