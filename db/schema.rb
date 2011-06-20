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

ActiveRecord::Schema.define(:version => 20110618233635) do

  create_table "assignments", :force => true do |t|
    t.integer  "team_id"
    t.integer  "project_id"
    t.boolean  "assigned",    :default => false
    t.string   "assigned_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["project_id"], :name => "index_assignments_on_project_id"
  add_index "assignments", ["team_id"], :name => "index_assignments_on_team_id"

  create_table "comments", :force => true do |t|
    t.integer  "task_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["task_id"], :name => "index_comments_on_task_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.integer  "country"
    t.string   "address"
    t.integer  "employees_number"
    t.decimal  "capital",          :default => 5000.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["team_id"], :name => "index_members_on_team_id"
  add_index "members", ["user_id"], :name => "index_members_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "client_id"
    t.text     "description"
    t.decimal  "budget",      :default => 100.0
    t.text     "side_notes"
    t.boolean  "finished",    :default => false
    t.datetime "start_date"
    t.datetime "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"
  add_index "projects", ["name"], :name => "index_projects_on_name", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "tasks", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.text     "description"
    t.integer  "priority"
    t.decimal  "progress"
    t.datetime "start_date"
    t.datetime "due"
    t.boolean  "finished",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["name"], :name => "index_tasks_on_name", :unique => true
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.integer  "role"
    t.string   "username"
    t.string   "mobile_number"
    t.integer  "spoken_language"
    t.integer  "country"
    t.boolean  "admin",                                 :default => false
    t.text     "name"
    t.string   "image"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workers", :force => true do |t|
    t.integer  "company_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["company_id"], :name => "index_workers_on_company_id"
  add_index "workers", ["team_id"], :name => "index_workers_on_team_id"

end
