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

ActiveRecord::Schema.define(version: 20161103154101) do

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
    t.integer  "article_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "image_url"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",               null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "color"
    t.integer  "parent_category_id"
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
    t.string   "name",       null: false
    t.integer  "drug_id"
    t.integer  "country_id"
    t.decimal  "reputation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["drug_id"], name: "index_companies_on_drug_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drug_categories", force: :cascade do |t|
    t.integer "drug_id"
    t.integer "category_id"
  end

  create_table "drug_generics", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "generic_id"
    t.integer  "unit_id"
    t.string   "concentration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "drugs", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "category_id"
    t.float    "price"
    t.float    "concentration"
    t.string   "unit"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.decimal  "contents"
    t.integer  "form_id"
    t.integer  "company_id"
    t.string   "image_url"
    t.index ["category_id"], name: "index_drugs_on_category_id"
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

  create_table "generics", force: :cascade do |t|
    t.string   "name"
    t.datetime "invented_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "image_url"
    t.string   "wikipedia_page_url"
    t.text     "wikipedia_description"
    t.text     "wikipedia_summary"
    t.string   "wikipedia_image_urls"
    t.string   "wikipedia_links"
    t.string   "wikipedia_extlinks"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.decimal  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "rx_drugs", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
