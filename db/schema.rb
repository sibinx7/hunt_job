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

ActiveRecord::Schema.define(version: 20150523040709) do

  create_table "admin_settings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "type",                   default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "bank_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "address"
    t.string   "place"
    t.string   "account_no"
    t.string   "ifsc_code"
    t.string   "card_no"
    t.string   "card_csc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bids", force: true do |t|
    t.text     "details"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "bid"
    t.integer  "duration"
    t.boolean  "status"
    t.integer  "percentage"
    t.boolean  "granted"
    t.boolean  "accepted"
    t.datetime "accepted_date"
    t.text     "client_feedback"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "milestones", force: true do |t|
    t.string  "milestone"
    t.integer "bid_id"
    t.integer "payment"
    t.boolean "status"
    t.integer "percentage"
    t.boolean "request_payment"
    t.boolean "grant_payment"
  end

  create_table "notifications", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "not_type"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "related_task"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "sender"
    t.integer  "receiver"
    t.integer  "project_id"
    t.integer  "bid_id"
    t.integer  "milestone_id"
    t.integer  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "creator"
    t.integer  "min_budget"
    t.integer  "max_budget"
    t.date     "close_date"
    t.string   "assigned_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",         limit: 1
    t.boolean  "close"
    t.datetime "completed_date"
  end

  create_table "projects_skills", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "skill_id"
  end

  add_index "projects_skills", ["project_id", "skill_id"], name: "index_projects_skills_on_project_id_and_skill_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "creator"
    t.string   "service_image"
    t.string   "service_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string "name"
  end

  create_table "skills_users", force: true do |t|
    t.integer "skill_id"
    t.integer "user_id"
  end

  create_table "user_project_details", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_completed"
    t.integer  "project_ongoing"
    t.integer  "project_lost"
    t.integer  "user_income",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_lost_money"
  end

  create_table "user_ratings", force: true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.integer  "rating"
    t.integer  "rated_by"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "country"
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.text     "user_info"
    t.integer  "user_rating"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
