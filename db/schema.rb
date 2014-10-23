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

ActiveRecord::Schema.define(version: 20141023010519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "assistances", force: true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string  "title"
    t.integer "category_id"
  end

  create_table "categories_exchanges", force: true do |t|
    t.integer "category_id"
    t.integer "exchange_id"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "person_in_need_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exchanges", force: true do |t|
    t.boolean  "is_offer"
    t.boolean  "is_demand"
    t.string   "title"
    t.integer  "quantity"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.integer  "status_cd"
    t.integer  "radius"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "person_in_need_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_date"
    t.integer  "created_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "file_attachment_file_name"
    t.string   "file_attachment_content_type"
    t.integer  "file_attachment_file_size"
    t.datetime "file_attachment_updated_at"
    t.integer  "category_id"
  end

  create_table "keywords", force: true do |t|
    t.string   "value"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer "organization_id"
    t.integer "user_id"
    t.boolean "founder"
    t.boolean "admin"
    t.boolean "validated"
  end

  add_index "memberships", ["user_id", "organization_id"], name: "index_memberships_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "organisation_name"
    t.string   "addr_street"
    t.string   "addr_postcode"
    t.string   "addr_city"
    t.string   "phone_number"
    t.string   "vat_number"
    t.string   "site_url"
    t.string   "facebook_url"
    t.text     "description"
    t.boolean  "use_own_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "organisation_description"
  end

  create_table "proposals", force: true do |t|
    t.text     "description"
    t.integer  "status_cd"
    t.integer  "exchange_id"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "person_in_need_id"
    t.integer  "proposer_rating"
    t.string   "proposer_msg"
    t.integer  "owner_rating"
    t.string   "owner_msg"
    t.boolean  "is_visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_searches", force: true do |t|
    t.string   "title"
    t.text     "explanation"
    t.integer  "organisation"
    t.integer  "user"
    t.integer  "city"
    t.float    "city_radius"
    t.integer  "category"
    t.integer  "type"
    t.integer  "frequency"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "username"
    t.string   "addr_street"
    t.string   "addr_postcode"
    t.string   "addr_city"
    t.string   "phone_number"
    t.string   "id_card_number"
    t.string   "facebook_url"
    t.boolean  "is_system_admin"
    t.integer  "status"
    t.string   "id_card_file_name"
    t.string   "id_card_content_type"
    t.integer  "id_card_file_size"
    t.datetime "id_card_updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "country"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "fullname"
    t.string   "language_spoken"
    t.string   "personal_description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
