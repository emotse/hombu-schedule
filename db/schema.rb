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

ActiveRecord::Schema.define(:version => 20120201063219) do

  create_table "scheduled_classes", :force => true do |t|
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shihan_id"
  end

  create_table "shihans", :force => true do |t|
    t.string   "name_en"
    t.string   "name_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subbed_classes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scheduled_class_id"
    t.integer  "sub_id"
  end

  create_table "subs", :force => true do |t|
    t.string   "name_en"
    t.string   "name_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end