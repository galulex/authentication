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

ActiveRecord::Schema.define(:version => 20130209181635) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "employee_limit"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id_id"
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job"
    t.string   "email"
    t.string   "password_digest"
    t.string   "token"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "new_email"
    t.string   "new_email_token"
    t.string   "deleted_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

end
