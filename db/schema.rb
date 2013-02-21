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

ActiveRecord::Schema.define(:version => 20130220231830) do

  create_table "companies", :force => true do |t|
    t.string   "slug"
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

  add_index "companies", ["slug"], :name => "index_companies_on_slug", :unique => true

  create_table "company_drafts", :force => true do |t|
    t.integer  "company_id"
    t.string   "slug"
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

  add_index "company_drafts", ["company_id"], :name => "index_company_drafts_on_company_id"
  add_index "company_drafts", ["slug"], :name => "index_company_drafts_on_slug", :unique => true

  create_table "logins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "logins", ["user_id"], :name => "index_logins_on_user_id"

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
    t.string   "slug"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.string   "status",                                              :default => "draft"
    t.boolean  "featured"
    t.decimal  "rating_average",        :precision => 3, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "product_drafts", ["product_id"], :name => "index_product_drafts_on_product_id"
  add_index "product_drafts", ["slug"], :name => "index_product_drafts_on_slug", :unique => true

  create_table "product_ratings", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_ratings", ["product_id", "user_id"], :name => "index_product_ratings_on_product_id_and_user_id", :unique => true

  create_table "product_reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "title"
    t.text     "review"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_reviews", ["product_id"], :name => "index_product_reviews_on_product_id"
  add_index "product_reviews", ["user_id"], :name => "index_product_reviews_on_user_id"

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
    t.string   "slug"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.string   "status",                                              :default => "draft"
    t.boolean  "featured"
    t.decimal  "rating_average",        :precision => 3, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "products", ["company_id"], :name => "index_products_on_company_id"
  add_index "products", ["slug"], :name => "index_products_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.integer  "role_id"
    t.string   "type"
    t.boolean  "invited"
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
    t.datetime "deleted_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
