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

ActiveRecord::Schema.define(version: 20170221023820) do

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.decimal  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "article_categories", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "article_comments", force: :cascade do |t|
    t.integer "article_id"
    t.integer "comment_id"
    t.index ["article_id"], name: "index_article_comments_on_article_id"
    t.index ["comment_id"], name: "index_article_comments_on_comment_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.string   "image_url"
    t.integer  "view_count", default: 0, null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                           null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "color"
    t.integer  "parent_category_id"
    t.text     "description"
    t.integer  "view_count",         default: 0, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.decimal  "rating"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "drug_id"
    t.integer  "country_id"
    t.decimal  "reputation"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "view_count", default: 0, null: false
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["drug_id"], name: "index_companies_on_drug_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drug_categories", id: false, force: :cascade do |t|
    t.integer "drug_id"
    t.integer "category_id"
  end

  create_table "drug_generics", force: :cascade do |t|
    t.integer "drug_id"
    t.integer "generic_id"
    t.integer "unit_id"
    t.string  "concentration"
  end

  create_table "drugs", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "country_id"
    t.float    "price"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.decimal  "contents"
    t.integer  "form_id"
    t.integer  "company_id"
    t.string   "image_url"
    t.integer  "view_count", default: 0, null: false
    t.index ["company_id"], name: "index_drugs_on_company_id"
    t.index ["country_id"], name: "index_drugs_on_country_id"
    t.index ["form_id"], name: "index_drugs_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name"
  end

  create_table "formulations", force: :cascade do |t|
    t.integer  "generic_id"
    t.text     "steps"
    t.integer  "category_id"
    t.integer  "comment_id"
    t.integer  "like_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "generics", force: :cascade do |t|
    t.string   "name"
    t.datetime "invented_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_url"
    t.string   "wikipedia_page_url"
    t.text     "wikipedia_summary"
    t.string   "wikipedia_image_urls"
    t.string   "wikipedia_links"
    t.string   "wikipedia_extlinks"
    t.integer  "view_count",           default: 0, null: false
    t.string   "slug"
    t.index ["slug"], name: "index_generics_on_slug"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.integer  "comment_id"
    t.integer  "rx_id"
    t.integer  "formulation_id"
    t.integer  "category_id"
    t.integer  "company_id"
    t.integer  "question_id"
    t.integer  "generic_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "user_id"
    t.decimal  "discount"
    t.datetime "expiry"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "age"
    t.datetime "birth_day"
    t.text     "patient_history"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.integer  "user_id"
    t.decimal  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "rx_drugs", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "rx_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rxes", force: :cascade do |t|
    t.integer  "patient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "diagnosis_id"
    t.index ["patient_id"], name: "index_rxes_on_patient_id"
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "drug_generic_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_articles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profession"
    t.string   "gender"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.integer  "country_id",             default: 70
    t.string   "image_url"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "view_count",             default: 0,  null: false
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.integer  "animatable_id"
    t.string   "animatable_type"
    t.string   "vid_id"
    t.text     "thumbnails"
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
