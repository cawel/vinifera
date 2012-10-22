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

ActiveRecord::Schema.define(:version => 20100521023417) do

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

  create_table "cellar_wines", :force => true do |t|
    t.integer  "wine_id",    :null => false
    t.integer  "person_id",  :null => false
    t.string   "note"
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
    t.text     "description"
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

  create_table "timeline_events", :force => true do |t|
    t.string   "event_type"
    t.string   "subject_type"
    t.string   "actor_type"
    t.string   "secondary_subject_type"
    t.integer  "subject_id"
    t.integer  "actor_id"
    t.integer  "secondary_subject_id"
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
    t.integer  "country_id"
    t.integer  "category_id"
    t.integer  "region_id"
    t.string   "code_saq"
    t.string   "cup"
    t.integer  "nature_id"
    t.string   "format"
    t.decimal  "price",          :precision => 6, :scale => 2
    t.string   "provider"
    t.decimal  "alcool",         :precision => 5, :scale => 2
    t.string   "image_filename"
    t.integer  "sub_region_id"
    t.integer  "appellation_id"
    t.integer  "flavor_id"
    t.integer  "times_updated",                                :default => 0, :null => false
  end

  add_index "wines", ["code_saq"], :name => "index_wines_on_code_saq"

end
