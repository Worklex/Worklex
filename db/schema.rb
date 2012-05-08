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

ActiveRecord::Schema.define(:version => 0) do

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "token",              :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.string   "api_key"
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_reset"
    t.string   "handle"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["handle"], :name => "index_users_on_handle"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["token"], :name => "index_users_on_token"

  create_table "tasks", :force => true do |t|
    t.integer  "owner_id"
    t.string   "title",                   :limit => 128
    t.string   "text",                    :limit => 256
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "assignments", ["task_id"], :name => "index_assignments_on_task_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"
  
end
