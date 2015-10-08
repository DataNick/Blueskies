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

ActiveRecord::Schema.define(version: 20151008200646) do

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

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "name"
    t.decimal  "last_price"
    t.datetime "last_trade"
    t.string   "stock_exchange"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "historical_prices", "stocks"
end
