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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140519054730) do

  create_table "answers", force: true do |t|
    t.integer  "test_id"
    t.string   "question_name"
    t.string   "applicant_answer"
    t.integer  "is_correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "test_question"
    t.string   "option_one"
    t.string   "option_two"
    t.string   "option_three"
    t.string   "option_four"
    t.string   "question_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.integer  "score",                    default: 0
    t.integer  "total_questions_answered", default: 0
    t.string   "start_time"
    t.string   "finished_time"
    t.string   "time_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
