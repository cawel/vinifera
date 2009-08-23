# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090823221035) do

  create_table "appellations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flavors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "natures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name",                        :limit => 100, :default => ""
    t.string   "email",                       :limit => 100
    t.string   "crypted_password",            :limit => 40
    t.string   "salt",                        :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",              :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "password_reset_code"
    t.datetime "password_reset_code_expires"
    t.boolean  "admin",                                      :default => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "weight"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "rating_id"
    t.integer  "wine_id"
    t.text     "comment"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "varieties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variety_wines", :force => true do |t|
    t.integer "variety_id"
    t.integer "wine_id"
  end

  create_table "wines", :force => true do |t|
    t.string   "name"
    t.integer  "color_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",      :default => 0, :null => false
    t.integer  "country_id"
    t.integer  "category_id"
    t.integer  "region_id"
    t.string   "code_saq"
    t.string   "cup"
    t.integer  "nature_id"
    t.string   "format"
    t.decimal  "price"
    t.string   "provider"
    t.decimal  "alcool"
    t.string   "image_filename"
    t.integer  "sub_region_id"
    t.integer  "appellation_id"
    t.integer  "flavor_id"
  end

  add_index "wines", ["code_saq"], :name => "index_wines_on_code_saq", :unique => true

end
