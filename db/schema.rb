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

ActiveRecord::Schema.define(:version => 20100608161322) do

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "purpose"
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "volunteer",  :default => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "email"
    t.string   "website"
    t.text     "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pin"
  end

  create_table "postings", :force => true do |t|
    t.integer  "blog_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.string   "atomid"
    t.string   "body_format"
    t.string   "cached_tag_list"
    t.text     "excerpt"
    t.text     "body"
    t.boolean  "draft",           :default => true
    t.boolean  "featured",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_on"
  end

  create_table "reports", :force => true do |t|
    t.text     "description"
    t.integer  "oil"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wetlands"
    t.string   "wildlife"
    t.string   "device_id"
    t.integer  "developer_id"
    t.integer  "organization_id"
    t.boolean  "within_oil_spill",   :default => false
    t.string   "slug"
    t.integer  "state_id"
  end

  add_index "reports", ["latitude", "longitude", "device_id"], :name => "index_reports", :unique => true

  create_table "states", :force => true do |t|
    t.string "name"
    t.string "code"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "company"
    t.string   "website"
    t.string   "twitter"
    t.string   "blog"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "bio"
    t.boolean  "admin",              :default => false
    t.boolean  "listed"
    t.integer  "position"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
