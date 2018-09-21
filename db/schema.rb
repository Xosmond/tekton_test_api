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

ActiveRecord::Schema.define(version: 2018_09_20_024155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "sign", null: false
    t.decimal "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "doc", null: false
    t.string "names", null: false
    t.string "last_names", null: false
    t.datetime "birth_date", null: false
    t.datetime "admission_date", default: "2018-09-21 16:52:32", null: false
    t.datetime "exit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "code", null: false
    t.string "description"
    t.string "type"
    t.decimal "amount", null: false
    t.decimal "real_amount", null: false
    t.decimal "box_amount", null: false
    t.decimal "box_all_amount", null: false
    t.bigint "currency_id", null: false
    t.decimal "rate", null: false
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_movements_on_currency_id"
    t.index ["employee_id"], name: "index_movements_on_employee_id"
  end

end
