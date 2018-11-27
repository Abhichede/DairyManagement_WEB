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

ActiveRecord::Schema.define(version: 2018_11_27_124500) do

  create_table "customer_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "customer_id"
    t.date "date"
    t.decimal "amount", precision: 10
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "address"
    t.string "cattle_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_collections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "customer_id"
    t.date "date"
    t.time "time"
    t.string "shift"
    t.decimal "litre", precision: 8, scale: 2
    t.decimal "fat", precision: 8, scale: 2
    t.decimal "lacto", precision: 8, scale: 2
    t.decimal "snf", precision: 8, scale: 2
    t.decimal "water_level", precision: 8, scale: 2
    t.decimal "rate", precision: 8, scale: 2
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_charts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cattle_type"
    t.decimal "snf", precision: 8, scale: 2
    t.decimal "fat", precision: 8, scale: 2
    t.decimal "rate", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
