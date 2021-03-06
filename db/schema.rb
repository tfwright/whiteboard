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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130121014308) do

  create_table "announcements", :force => true do |t|
    t.integer  "course_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "due_at"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepting_submissions"
    t.float    "weight"
  end

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.date     "begins_on"
    t.date     "ends_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "code"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "attachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attached_file_name"
    t.string   "attached_content_type"
    t.integer  "attached_file_size"
    t.datetime "attached_updated_at"
    t.string   "attachable_type"
  end

  create_table "grades", :force => true do |t|
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weight"
  end

  create_table "links", :force => true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", :force => true do |t|
    t.integer  "assignment_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt",                         :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "name"
    t.string   "time_zone"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
