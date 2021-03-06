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

ActiveRecord::Schema.define(:version => 20140427231108) do

  create_table "authentications", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "location"
    t.string   "image"
    t.string   "description"
    t.string   "nickname"
  end

  add_index "authentications", ["uid", "provider"], :name => "index_authentications_on_uid_and_provider"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "clicks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type"
  end

  add_index "clicks", ["resource_id", "resource_type"], :name => "index_clicks_on_resource_id_and_resource_type"
  add_index "clicks", ["user_id"], :name => "index_clicks_on_user_id"

  create_table "codemark_topics", :force => true do |t|
    t.integer  "codemark_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codemark_topics", ["codemark_id"], :name => "index_codemark_topics_on_codemark_id"
  add_index "codemark_topics", ["topic_id"], :name => "index_codemark_topics_on_topic_id"

  create_table "codemarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "title"
    t.tsvector "search"
    t.boolean  "private",       :default => false
    t.string   "resource_type"
    t.integer  "group_id"
    t.text     "source"
  end

  add_index "codemarks", ["created_at"], :name => "index_codemarks_on_created_at"
  add_index "codemarks", ["group_id"], :name => "index_codemarks_on_group_id"
  add_index "codemarks", ["resource_id", "created_at"], :name => "index_codemarks_on_resource_id_and_created_at"
  add_index "codemarks", ["resource_id", "resource_type"], :name => "index_codemarks_on_resource_id_and_resource_type"
  add_index "codemarks", ["resource_id"], :name => "index_codemarks_on_resource_id"
  add_index "codemarks", ["resource_type"], :name => "index_codemarks_on_resource_type"
  add_index "codemarks", ["search"], :name => "codemarks_search_index"
  add_index "codemarks", ["user_id"], :name => "index_codemarks_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          :default => 0, :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["lft"], :name => "index_comments_on_lft"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["rgt"], :name => "index_comments_on_rgt"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "groups", :force => true do |t|
    t.string "name"
  end

  create_table "groups_users", :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "resources", :force => true do |t|
    t.integer  "author_id"
    t.integer  "clicks_count",       :default => 0
    t.integer  "codemarks_count",    :default => 0
    t.string   "type"
    t.hstore   "properties"
    t.hstore   "indexed_properties"
    t.tsvector "search"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "resources", ["author_id"], :name => "index_resources_on_author_id"
  add_index "resources", ["clicks_count"], :name => "index_resources_on_clicks_count"
  add_index "resources", ["codemarks_count"], :name => "index_resources_on_codemarks_count"
  add_index "resources", ["created_at"], :name => "index_resources_on_created_at"
  add_index "resources", ["indexed_properties"], :name => "resources_indexed_properties"
  add_index "resources", ["search"], :name => "resources_search_index"
  add_index "resources", ["type"], :name => "index_resources_on_type"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "slug"
    t.tsvector "search"
    t.integer  "group_id"
  end

  add_index "topics", ["group_id"], :name => "index_topics_on_group_id"
  add_index "topics", ["slug"], :name => "index_topics_on_slug", :unique => true
  add_index "topics", ["title"], :name => "index_topics_on_title"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "location"
    t.string   "image"
    t.text     "description"
    t.string   "nickname"
    t.string   "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["nickname"], :name => "index_users_on_nickname"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
