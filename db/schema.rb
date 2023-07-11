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

ActiveRecord::Schema[7.0].define(version: 2023_07_06_040911) do
  create_table "stocks", force: :cascade do |t|
    t.string "indices"
    t.string "identifier"
    t.float "last_price"
    t.integer "owned_amount"
    t.string "category"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "source_wallet_id"
    t.integer "target_wallet_id"
    t.decimal "amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password", null: false
    t.datetime "access_token_expired_date"
    t.boolean "is_team_admin", default: false
    t.integer "team_id"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "walletable_type"
    t.integer "walletable_id"
    t.float "balance", default: 0.0
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable"
  end

end
