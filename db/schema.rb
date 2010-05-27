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

ActiveRecord::Schema.define(:version => 20100526204040) do

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "purpose",    :limit => 255
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "volunteer",                 :default => false
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

  create_table "reports", :force => true do |t|
    t.string   "description"
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
    t.integer  "organization_id",    :limit => 255
    t.string   "device_id"
    t.integer  "developer_id"
  end

end
