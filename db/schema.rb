# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_20_231524) do

  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "local_id", null: false
    t.index ["local_id", "created_at"], name: "index_articles_on_local_id_and_created_at"
    t.index ["local_id"], name: "index_articles_on_local_id"
  end

  create_table "bookmarks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "local_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_id"], name: "index_bookmarks_on_local_id"
    t.index ["user_id", "local_id"], name: "index_bookmarks_on_user_id_and_local_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "category"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "footprints", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "visitoruser_id"
    t.integer "visiteduser_id"
    t.integer "visitorlocal_id"
    t.integer "visitedlocal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "profile"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.integer "prefecture_code"
    t.string "image"
    t.index ["confirmation_token"], name: "index_locals_on_confirmation_token", unique: true
    t.index ["email"], name: "index_locals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_locals_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_locals_on_unlock_token", unique: true
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "talkroom_id", null: false
    t.text "content"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sender_type"
    t.bigint "sender_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender"
    t.index ["talkroom_id", "sender_type", "created_at"], name: "index_messages_on_talkroom_id_and_sender_type_and_created_at"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "notice_to", null: false
    t.boolean "is_for_user", null: false
    t.integer "notice_from", null: false
    t.boolean "is_from_user", null: false
    t.string "action", default: "", null: false
    t.bigint "bookmark_id"
    t.bigint "talkroom_id"
    t.bigint "message_id"
    t.bigint "article_id"
    t.boolean "is_checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "footprint_id"
    t.index ["article_id"], name: "index_notifications_on_article_id"
    t.index ["bookmark_id"], name: "index_notifications_on_bookmark_id"
    t.index ["footprint_id"], name: "index_notifications_on_footprint_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["notice_from", "is_from_user"], name: "index_notifications_on_notice_from_and_is_from_user"
    t.index ["notice_to", "is_for_user"], name: "index_notifications_on_notice_to_and_is_for_user"
    t.index ["talkroom_id"], name: "index_notifications_on_talkroom_id"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "introduction"
    t.integer "population"
    t.float "temperature"
    t.integer "moved_in"
    t.integer "waiting_children"
    t.integer "land_price"
    t.integer "income"
    t.float "crime_rate"
    t.bigint "local_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "catchphrase"
    t.index ["local_id"], name: "index_profiles_on_local_id"
  end

  create_table "scores", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "nature"
    t.integer "accessibility"
    t.integer "budget"
    t.integer "job_support"
    t.integer "family_support"
    t.integer "culture"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "local_id"
    t.index ["local_id"], name: "index_scores_on_local_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "sea"
    t.boolean "mountain"
    t.boolean "river"
    t.boolean "field"
    t.boolean "hotspring"
    t.boolean "north"
    t.boolean "south"
    t.boolean "easy_to_go"
    t.boolean "small_city"
    t.boolean "car"
    t.boolean "train"
    t.boolean "low_price"
    t.boolean "moving_support"
    t.boolean "entrepreneur_support"
    t.boolean "child_care_support"
    t.boolean "job_change_support"
    t.boolean "park"
    t.boolean "education"
    t.boolean "food"
    t.boolean "architecture"
    t.boolean "history"
    t.boolean "event"
    t.boolean "tourism"
    t.bigint "local_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "article_id"
    t.index ["article_id"], name: "index_tags_on_article_id"
    t.index ["local_id"], name: "index_tags_on_local_id"
  end

  create_table "talkrooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "local_id"
    t.index ["local_id"], name: "index_talkrooms_on_local_id"
    t.index ["user_id", "local_id"], name: "index_talkrooms_on_user_id_and_local_id", unique: true
    t.index ["user_id"], name: "index_talkrooms_on_user_id"
  end

  create_table "user_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "prefecture_code", null: false
    t.integer "age", null: false
    t.string "proposed_site", default: "", null: false
    t.string "job", default: "", null: false
    t.string "family_structure", default: "", null: false
    t.string "timing", default: "", null: false
    t.text "content", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "locals"
  add_foreign_key "bookmarks", "locals"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "messages", "talkrooms"
  add_foreign_key "notifications", "articles"
  add_foreign_key "notifications", "bookmarks"
  add_foreign_key "notifications", "footprints"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "talkrooms"
  add_foreign_key "profiles", "locals"
  add_foreign_key "scores", "locals"
  add_foreign_key "scores", "users"
  add_foreign_key "tags", "articles"
  add_foreign_key "tags", "locals"
  add_foreign_key "talkrooms", "locals"
  add_foreign_key "talkrooms", "users"
end
