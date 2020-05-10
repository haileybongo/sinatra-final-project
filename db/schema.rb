# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_10_055529) do

  create_table "plants", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "notes"
    t.string "water_id"
    t.string "light"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waters", force: :cascade do |t|
    t.integer "plant_id"
    t.string "name"
    t.string "winter"
    t.string "summer"
    t.string "soil"
    t.string "humidity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
