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

ActiveRecord::Schema.define(version: 20200331172826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "text"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "arguments", force: :cascade do |t|
    t.text "text"
    t.string "argument_type"
    t.bigint "debate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debate_id"], name: "index_arguments_on_debate_id"
  end

  create_table "debates", force: :cascade do |t|
    t.text "central_argument"
    t.bigint "token_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_debates_on_post_id"
    t.index ["token_id"], name: "index_debates_on_token_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.integer "post_id"
    t.string "post_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "have_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "have_attachments", force: :cascade do |t|
    t.integer "have_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "haves", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "price"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "details"
    t.integer "user_id"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "layers", force: :cascade do |t|
    t.string "name"
    t.integer "layerable_id"
    t.integer "creator_id"
    t.text "layer_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "layerable_type"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.bigint "user_id"
    t.text "message"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "hypertext"
    t.text "note"
    t.bigint "token_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_notes_on_post_id"
    t.index ["token_id"], name: "index_notes_on_token_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id"
  end

  create_table "pics", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "post_body"
    t.integer "creator_id"
    t.string "post_type"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "parent_post_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
  end

  create_table "questions", force: :cascade do |t|
    t.text "text"
    t.bigint "token_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_questions_on_post_id"
    t.index ["token_id"], name: "index_questions_on_token_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.integer "rateable_id"
    t.string "rateable_type"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "sender_id"
    t.integer "reciever_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "layer_id"
    t.index ["post_id"], name: "index_taggings_on_post_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tag_body"
    t.integer "creator_id"
    t.string "slug"
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "tokens", force: :cascade do |t|
    t.string "token_type"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trackings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.text "bio"
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "video"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  create_table "wants", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "price"
  end

  create_table "wants_attachments", force: :cascade do |t|
    t.integer "want_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "arguments", "debates"
  add_foreign_key "debates", "posts"
  add_foreign_key "debates", "tokens"
  add_foreign_key "notes", "posts"
  add_foreign_key "notes", "tokens"
  add_foreign_key "questions", "posts"
  add_foreign_key "questions", "tokens"
  add_foreign_key "taggings", "posts"
  add_foreign_key "taggings", "tags"
end
