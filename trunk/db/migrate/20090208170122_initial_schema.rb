class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table "comments", :force => true do |t|
      t.string   "comment",    :limit => 1024
      t.integer  "user_id",    :limit => 11
      t.integer  "notice_id",  :limit => 11
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "notices", :force => true do |t|
      t.string   "subject",       :limit => 255
      t.string   "description",   :limit => 1024
      t.integer  "user_id",       :limit => 11
      t.integer  "project_id",    :limit => 11
      t.integer  "category_id",   :limit => 11
      t.string  "bug_ids",        :limit =>255
      t.string  "status_id",      :limit=>1
      t.integer "impact_id",       :limit=>11
      t.integer "release_id",     :limit=>11
      t.date  "plannded_date"
      t.date  "integrated_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "projects", :force => true do |t|
      t.string   "name",         :limit => 32
      t.string   "display_name", :limit => 64
      t.string   "description",  :limit => 1024
      t.integer  "user_id",     :limit => 11
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "email",       :limit => 50
      t.string  "name",         :limit => 50
      t.string  "login",        :limit => 20
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "categories", :force => true do |t|
      t.string    "name",       :limit => 50
      t.string    "description",         :limit => 50
      t.integer   "project_id",  :limit => 11
      t.integer   "user_id",      :limit => 11
      t.datetime  "created_at"
      t.datetime  "updated_at"
    end

    create_table "statuses" , :force => true do |t|
      t.string "name" , :limit => 10
    end

    create_table "impacts" , :force => true do |t|
      t.string "name" , :limit => 10
    end
    create_table "releases" , :force => true do |t|
      t.string "name" , :limit => 20
      t.string "description", :limit=>70
      t.string "version",   :limit=>20
      t.integer   "project_id",  :limit => 11
      t.integer   "user_id",      :limit => 11
      t.datetime  "created_at"
      t.datetime  "updated_at"
    end
  end
  
  def self.down
  end
end
