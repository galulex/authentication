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

ActiveRecord::Schema.define(:version => 20130212230040) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "synopsis"
    t.text     "description"
    t.integer  "employee_limit",    :default => 20
    t.string   "website"
    t.string   "status",            :default => "draft"
    t.string   "street1"
    t.string   "street2"
    t.string   "country"
    t.string   "state"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.boolean  "featured",          :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "company_drafts", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "synopsis"
    t.text     "description"
    t.integer  "employee_limit",    :default => 20
    t.string   "website"
    t.string   "status",            :default => "draft"
    t.string   "street1"
    t.string   "street2"
    t.string   "country"
    t.string   "state"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.boolean  "featured",          :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "product_drafts", :force => true do |t|
    t.integer  "company_id"
    t.integer  "product_id"
    t.string   "software_file_name"
    t.string   "software_content_type"
    t.integer  "software_file_size"
    t.datetime "software_updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.boolean  "featured"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "company_id"
    t.string   "software_file_name"
    t.string   "software_content_type"
    t.integer  "software_file_size"
    t.datetime "software_updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.boolean  "featured"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.integer  "role_id"
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
