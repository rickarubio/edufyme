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

ActiveRecord::Schema.define(:version => 20140302071311) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "category_img_url"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "course_teachers", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.boolean  "starred"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "starred"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "completed",  :default => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "school_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "course_url"
    t.string   "course_img_url"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "short_description"
  end

  create_table "schools", :force => true do |t|
    t.string   "name",           :default => "School Name Not Provided"
    t.string   "school_url"
    t.string   "school_img_url"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "teacher_img_url"
    t.string   "teacher_url"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
