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

ActiveRecord::Schema.define(:version => 20090208170122) do

  create_table "categories", :force => true do |t|
    t.string   "name",        :limit => 50
    t.string   "description", :limit => 50
    t.integer  "project_id",  :limit => 11
    t.integer  "user_id",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "comment",    :limit => 1024
    t.integer  "user_id",    :limit => 11
    t.integer  "notice_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impacts", :force => true do |t|
    t.string "name", :limit => 10
  end

  create_table "notices", :force => true do |t|
    t.string   "subject"
    t.string   "description",     :limit => 1024
    t.integer  "user_id",         :limit => 11
    t.integer  "project_id",      :limit => 11
    t.integer  "category_id",     :limit => 11
    t.string   "bug_ids"
    t.string   "status_id",       :limit => 1
    t.integer  "impact_id",       :limit => 11
    t.integer  "release_id",      :limit => 11
    t.date     "planned_date"
    t.date     "integrated_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",         :limit => 32
    t.string   "display_name", :limit => 64
    t.string   "description",  :limit => 1024
    t.integer  "user_id",      :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", :force => true do |t|
    t.string   "name",        :limit => 20
    t.string   "description", :limit => 70
    t.string   "version",     :limit => 20
    t.integer  "project_id",  :limit => 11
    t.integer  "user_id",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string "name", :limit => 10
  end

  create_table "users", :force => true do |t|
    t.string   "email",      :limit => 50
    t.string   "name",       :limit => 50
    t.string   "login",      :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
