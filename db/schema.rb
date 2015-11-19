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

ActiveRecord::Schema.define(version: 20151023053650) do

  create_table "challenges", force: :cascade do |t|
    t.string   "difficulty"
    t.string   "focal_length_guess"
    t.string   "exposure_guess"
    t.string   "aperture_guess"
    t.string   "iso_speed_guess"
    t.boolean  "focal_length_correct"
    t.boolean  "exposure_correct"
    t.boolean  "aperture_correct"
    t.boolean  "iso_speed_correct"
    t.integer  "overall_score"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.integer  "image_id"
  end

  add_index "challenges", ["image_id"], name: "index_challenges_on_image_id"
  add_index "challenges", ["user_id"], name: "index_challenges_on_user_id"

  create_table "images", force: :cascade do |t|
    t.string   "photo_id"
    t.string   "title"
    t.string   "medium_url"
    t.string   "large_url"
    t.string   "original_url"
    t.string   "focal_length"
    t.string   "exposure"
    t.string   "aperture"
    t.string   "iso_speed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
