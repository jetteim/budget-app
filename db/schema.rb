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

ActiveRecord::Schema.define(version: 20171027065853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_account_groups_on_name", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "number", limit: 255, null: false
    t.string "type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "account_group_id"
    t.index ["number"], name: "index_accounts_on_number", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "goals", force: :cascade do |t|
    t.integer "category_id", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "period", limit: 255, default: "Month", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type", default: "Spend", null: false
    t.index ["category_id"], name: "index_goals_on_category_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "category_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "type", limit: 255, default: "Spend", null: false
    t.text "schedule", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_payments_on_category_id"
  end

  create_table "sorted_transactions", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "transaction_id", null: false
    t.integer "category_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "review", default: false, null: false
    t.integer "tag_ids", array: true
    t.text "note"
    t.index ["account_id"], name: "index_sorted_transactions_on_account_id"
    t.index ["category_id"], name: "index_sorted_transactions_on_category_id"
    t.index ["transaction_id"], name: "index_sorted_transactions_on_transaction_id"
  end

  create_table "sorting_rules", force: :cascade do |t|
    t.string "contains", limit: 255, null: false
    t.string "name", limit: 255
    t.integer "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "review", default: false, null: false
    t.integer "tag_ids", array: true
    t.index ["category_id"], name: "index_sorting_rules_on_category_id"
    t.index ["contains"], name: "index_sorting_rules_on_contains", unique: true
  end

  create_table "statements", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "balance", precision: 10, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "from_date"
    t.date "to_date"
    t.index ["account_id"], name: "index_statements_on_account_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "fit_id", limit: 255, null: false
    t.string "memo", limit: 255
    t.string "name", limit: 255
    t.string "payee", limit: 255
    t.datetime "posted_at", null: false
    t.string "ref_number", limit: 255
    t.string "type", limit: 255
    t.integer "account_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "statement_id"
    t.string "search", limit: 255, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["statement_id"], name: "index_transactions_on_statement_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "name"
    t.string "telegram"
    t.string "facebook"
    t.string "google"
    t.string "vk"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "token", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
