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

ActiveRecord::Schema[7.0].define(version: 2022_08_08_191505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "access_restriction_types", force: :cascade do |t|
    t.string "type_label"
    t.text "note"
    t.boolean "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "access_restriction_type_id"
    t.index ["type_label"], name: "index_access_restriction_types_on_type_label"
  end

  create_table "access_restrictions", force: :cascade do |t|
    t.string "jhu_id"
    t.bigint "access_restriction_type_id", null: false
    t.bigint "database_id", null: false
    t.text "note"
    t.string "private_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_restriction_type_id"], name: "index_access_restrictions_on_access_restriction_type_id"
    t.index ["database_id"], name: "index_access_restrictions_on_database_id"
  end

  create_table "database_headings", force: :cascade do |t|
    t.string "jhu_id"
    t.bigint "heading_id", null: false
    t.bigint "subheading_id", null: false
    t.bigint "database_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "database_heading_id"
    t.index ["database_id"], name: "index_database_headings_on_database_id"
    t.index ["heading_id", "subheading_id", "jhu_id", "database_id"], name: "multicolumn_db_heading_index", unique: true
    t.index ["heading_id", "subheading_id", "jhu_id"], name: "multicolumn_jhu_id_index", unique: true
    t.index ["heading_id"], name: "index_database_headings_on_heading_id"
    t.index ["subheading_id"], name: "index_database_headings_on_subheading_id"
  end

  create_table "databases", force: :cascade do |t|
    t.bigint "vendor_id"
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
    t.index ["vendor_id"], name: "index_databases_on_vendor_id"
  end

  create_table "headings", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "heading_id"
    t.index ["label"], name: "index_headings_on_label", unique: true
  end

  create_table "subheadings", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subheading_id"
    t.index ["label"], name: "index_subheadings_on_label", unique: true
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
    t.citext "brand_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.integer "vendor_gid"
    t.index "lower((brand_name)::text)", name: "index_brand_name_case_insensitive", unique: true
    t.index ["brand_name"], name: "index_vendors_on_brand_name", unique: true
    t.index ["vendor_id"], name: "index_vendors_on_vendor_id"
  end

  add_foreign_key "access_restrictions", "access_restriction_types"
  add_foreign_key "access_restrictions", "databases"
  add_foreign_key "database_headings", "databases"
  add_foreign_key "database_headings", "headings"
  add_foreign_key "database_headings", "subheadings"
  add_foreign_key "databases", "vendors"
  add_foreign_key "vendors", "vendors"
end
