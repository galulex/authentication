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

ActiveRecord::Schema.define(version: 20130302205222) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "logo"
    t.text     "synopsis"
    t.text     "description"
    t.integer  "employee_limit", default: 20
    t.string   "website"
    t.string   "status",         default: "draft"
    t.string   "street1"
    t.string   "street2"
    t.string   "country"
    t.string   "state"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.boolean  "featured",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["slug"], name: "index_companies_on_slug", unique: true, using: :btree

  create_table "company_drafts", force: true do |t|
    t.integer  "company_id"
    t.string   "slug"
    t.string   "name"
    t.string   "logo"
    t.text     "synopsis"
    t.text     "description"
    t.integer  "employee_limit", default: 20
    t.string   "website"
    t.string   "status",         default: "draft"
    t.string   "street1"
    t.string   "street2"
    t.string   "country"
    t.string   "state"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.boolean  "featured",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_drafts", ["company_id"], name: "index_company_drafts_on_company_id", using: :btree
  add_index "company_drafts", ["slug"], name: "index_company_drafts_on_slug", unique: true, using: :btree

  create_table "logins", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logins", ["user_id"], name: "index_logins_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "notification_type"
    t.text     "data"
    t.boolean  "read",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "product_categories", force: true do |t|
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["categorizable_id", "category_id"], name: "index_product_categories_on_categorizable_id_and_category_id", unique: true, using: :btree

  create_table "product_drafts", force: true do |t|
    t.integer  "company_id"
    t.integer  "product_id"
    t.string   "software"
    t.string   "icon"
    t.string   "image"
    t.string   "banner"
    t.string   "slug"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.string   "status",                                     default: "draft"
    t.boolean  "featured"
    t.decimal  "rating_average",     precision: 3, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "platform",                                   default: "android"
    t.boolean  "phone_form_factor",                          default: false
    t.boolean  "tablet_form_factor",                         default: false
    t.decimal  "single_pricing",     precision: 3, scale: 2
    t.string   "pricing_type",                               default: "single"
  end

  add_index "product_drafts", ["product_id"], name: "index_product_drafts_on_product_id", using: :btree
  add_index "product_drafts", ["slug"], name: "index_product_drafts_on_slug", unique: true, using: :btree

  create_table "product_images", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["imageable_id"], name: "index_product_images_on_imageable_id", using: :btree

  create_table "product_pricings", force: true do |t|
    t.integer  "pricingable_id"
    t.string   "pricingable_type"
    t.integer  "from"
    t.integer  "to"
    t.decimal  "price",            precision: 3, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_pricings", ["pricingable_id"], name: "index_product_pricings_on_pricingable_id", using: :btree

  create_table "product_ratings", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_ratings", ["product_id", "user_id"], name: "index_product_ratings_on_product_id_and_user_id", unique: true, using: :btree

  create_table "product_resources", force: true do |t|
    t.integer  "resourceable_id"
    t.string   "resourceable_type"
    t.string   "title"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_resources", ["resourceable_id"], name: "index_product_resources_on_resourceable_id", using: :btree

  create_table "product_reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "title"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_reviews", ["product_id", "user_id"], name: "index_product_reviews_on_product_id_and_user_id", unique: true, using: :btree

  create_table "product_videos", force: true do |t|
    t.integer  "videoable_id"
    t.string   "videoable_type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_videos", ["videoable_id"], name: "index_product_videos_on_videoable_id", using: :btree

  create_table "products", force: true do |t|
    t.integer  "company_id"
    t.string   "software"
    t.string   "icon"
    t.string   "image"
    t.string   "banner"
    t.string   "slug"
    t.string   "name"
    t.string   "version"
    t.text     "summary"
    t.text     "description"
    t.text     "features"
    t.text     "support"
    t.string   "status",                                     default: "draft"
    t.boolean  "featured"
    t.decimal  "rating_average",     precision: 3, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "platform",                                   default: "android"
    t.boolean  "phone_form_factor",                          default: false
    t.boolean  "tablet_form_factor",                         default: false
    t.decimal  "single_pricing",     precision: 3, scale: 2
    t.string   "pricing_type",                               default: "single"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
