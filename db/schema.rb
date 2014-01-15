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

ActiveRecord::Schema.define(version: 20140114232246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disciplinary_cards", force: true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.string   "reason"
    t.string   "colour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "next_of_kins", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relationship"
    t.string   "contact_number"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postcode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pre_enrolment_tests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "name"
    t.string   "answer1"
    t.string   "answer2"
    t.string   "answer3"
    t.string   "answer4"
    t.integer  "answer"
    t.integer  "order"
    t.integer  "section_id"
    t.integer  "pre_enrolment_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pre_enrolment_test_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "last_sign_in"
    t.integer  "role"
    t.string   "job"
    t.boolean  "health_issues"
    t.boolean  "is_supervisor"
    t.string   "cscs_number"
    t.date     "cscs_expiry_date"
    t.date     "date_of_birth"
    t.string   "national_insurance"
    t.date     "completed_pre_enrolment"
    t.date     "pre_enrolment_due"
    t.string   "contact_number"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
