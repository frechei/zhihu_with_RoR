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

ActiveRecord::Schema.define(version: 20160614070304) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "answer_votes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answer_votes", ["answer_id"], name: "index_answer_votes_on_answer_id"
  add_index "answer_votes", ["user_id"], name: "index_answer_votes_on_user_id"

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "replier_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["replier_id"], name: "index_answers_on_replier_id"

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "follow_questions", force: :cascade do |t|
    t.integer  "qs_follower_id"
    t.integer  "followed_qs_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "follow_questions", ["followed_qs_id"], name: "index_follow_questions_on_followed_qs_id"
  add_index "follow_questions", ["qs_follower_id", "followed_qs_id"], name: "index_follow_questions_on_qs_follower_id_and_followed_qs_id", unique: true
  add_index "follow_questions", ["qs_follower_id"], name: "index_follow_questions_on_qs_follower_id"

  create_table "follow_topics", force: :cascade do |t|
    t.integer  "tp_follower_id"
    t.integer  "followed_tp_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "follow_topics", ["followed_tp_id"], name: "index_follow_topics_on_followed_tp_id"
  add_index "follow_topics", ["tp_follower_id", "followed_tp_id"], name: "index_follow_topics_on_tp_follower_id_and_followed_tp_id", unique: true
  add_index "follow_topics", ["tp_follower_id"], name: "index_follow_topics_on_tp_follower_id"

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photos", ["question_id"], name: "index_photos_on_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "issue"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "questioner_id"
  end

  add_index "questions", ["questioner_id"], name: "index_questions_on_questioner_id"

  create_table "questions_topics", id: false, force: :cascade do |t|
    t.integer "topic_id",    null: false
    t.integer "question_id", null: false
  end

  add_index "questions_topics", ["question_id", "topic_id"], name: "index_questions_topics_on_question_id_and_topic_id"
  add_index "questions_topics", ["topic_id", "question_id"], name: "index_questions_topics_on_topic_id_and_question_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "topics", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "avatar"
    t.boolean  "admin",             default: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "location"
    t.string   "vocation"
    t.string   "gender",            default: "mars"
    t.string   "company"
    t.string   "position"
    t.string   "education"
    t.string   "major"
    t.string   "statements"
    t.integer  "agreements"
    t.integer  "thanks"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
