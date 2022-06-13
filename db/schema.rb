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

ActiveRecord::Schema[7.0].define(version: 2022_06_02_190058) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "database_headings", force: :cascade do |t|
    t.string "jhu_id"
    t.bigint "heading_id", null: false
    t.bigint "subheading_id", null: false
    t.bigint "database_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["database_id"], name: "index_database_headings_on_database_id"
    t.index ["heading_id"], name: "index_database_headings_on_heading_id"
    t.index ["subheading_id"], name: "index_database_headings_on_subheading_id"
  end

  create_table "databases", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.text "name"
    t.text "url"
    t.boolean "enable_proxy"
    t.text "description"
    t.text "internal_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jhu_id"
    t.index ["jhu_id"], name: "index_databases_on_jhu_id", unique: true
    t.index ["name"], name: "index_databases_on_name", unique: true
    t.index ["url"], name: "index_databases_on_url", unique: true
    t.index ["vendor_id"], name: "index_databases_on_vendor_id"
  end

  create_table "headings", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subheadings", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "reader"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "brand_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_name"], name: "index_vendors_on_brand_name", unique: true
  end

  add_foreign_key "database_headings", "databases"
  add_foreign_key "database_headings", "headings"
  add_foreign_key "database_headings", "subheadings"
  add_foreign_key "databases", "vendors"
end
