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

ActiveRecord::Schema.define(:version => 20110317141610) do

  create_table "beers", :force => true do |t|
    t.integer  "brewery_id"
    t.string   "style"
    t.string   "name"
    t.float    "abv"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beers", ["brewery_id"], :name => "index_beers_on_brewery_id"

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "breweries", ["name"], :name => "index_breweries_on_name", :unique => true

  create_table "tastings", :force => true do |t|
    t.integer  "beer_id"
    t.integer  "taster_id"
    t.integer  "rating"
    t.string   "comments"
    t.date     "tasted_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tastings", ["beer_id"], :name => "index_tastings_on_beer_id"
  add_index "tastings", ["taster_id"], :name => "index_tastings_on_taster_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
