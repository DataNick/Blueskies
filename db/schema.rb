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

ActiveRecord::Schema.define(version: 20151028162338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "historical_prices", force: :cascade do |t|
    t.integer  "stock_id"
    t.datetime "date"
    t.decimal  "day_price_close"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "historical_prices", ["stock_id"], name: "index_historical_prices_on_stock_id", using: :btree

  create_table "portfolio_stocks", force: :cascade do |t|
    t.integer  "stock_id"
    t.integer  "portfolio_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "portfolio_stocks", ["portfolio_id"], name: "index_portfolio_stocks_on_portfolio_id", using: :btree
  add_index "portfolio_stocks", ["stock_id"], name: "index_portfolio_stocks_on_stock_id", using: :btree

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.decimal  "cash"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "name"
    t.decimal  "last_price"
    t.datetime "last_trade"
    t.string   "stock_exchange"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "historical_prices", "stocks"
  add_foreign_key "portfolio_stocks", "portfolios"
  add_foreign_key "portfolio_stocks", "stocks"
  add_foreign_key "portfolios", "users"
end
