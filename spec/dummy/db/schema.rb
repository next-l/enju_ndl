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

ActiveRecord::Schema.define(:version => 20120305121726) do

  create_table "carrier_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "content_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "countries", :force => true do |t|
    t.string  "name",         :null => false
    t.text    "display_name"
    t.string  "alpha_2"
    t.string  "alpha_3"
    t.string  "numeric_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "countries", ["alpha_2"], :name => "index_countries_on_alpha_2"
  add_index "countries", ["alpha_3"], :name => "index_countries_on_alpha_3"
  add_index "countries", ["name"], :name => "index_countries_on_name"
  add_index "countries", ["numeric_3"], :name => "index_countries_on_numeric_3"

  create_table "creates", :force => true do |t|
    t.integer  "work_id"
    t.integer  "patron_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.string   "native_name"
    t.string   "iso_639_1"
    t.string   "iso_639_2"
    t.string   "iso_639_3"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "manifestations", :force => true do |t|
    t.text     "original_title"
    t.text     "title_transcription"
    t.text     "title_alternative"
    t.text     "title_alternative_transcription"
    t.string   "pub_date"
    t.string   "isbn"
    t.string   "nbn"
    t.string   "ndc"
    t.integer  "language_id"
    t.integer  "price"
    t.text     "description"
    t.string   "volume_number_string"
    t.integer  "carrier_type_id"
    t.integer  "content_type_id"
    t.integer  "start_page"
    t.integer  "end_page"
    t.float    "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "patrons", :force => true do |t|
    t.text     "full_name"
    t.text     "full_name_transcription"
    t.integer  "language_id"
    t.integer  "required_role_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "produces", :force => true do |t|
    t.integer  "manifestation_id"
    t.integer  "patron_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.integer  "score"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "series_has_manifestations", :force => true do |t|
    t.integer  "series_statement_id"
    t.integer  "manifestation_id"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "series_has_manifestations", ["manifestation_id"], :name => "index_series_has_manifestations_on_manifestation_id"
  add_index "series_has_manifestations", ["series_statement_id"], :name => "index_series_has_manifestations_on_series_statement_id"

  create_table "series_statement_merge_lists", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "series_statement_merges", :force => true do |t|
    t.integer  "series_statement_id",            :null => false
    t.integer  "series_statement_merge_list_id", :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "series_statement_merges", ["series_statement_id"], :name => "index_series_statement_merges_on_series_statement_id"
  add_index "series_statement_merges", ["series_statement_merge_list_id"], :name => "index_series_statement_merges_on_series_statement_merge_list_id"

  create_table "series_statements", :force => true do |t|
    t.text     "original_title"
    t.text     "title_transcription"
    t.text     "numbering"
    t.text     "title_subseries"
    t.text     "title_subseries_transcriptiom"
    t.text     "numbering_subseries"
    t.integer  "root_manifestation_id"
    t.string   "series_statement_identifier"
    t.text     "note"
    t.integer  "position"
    t.boolean  "periodical"
    t.string   "issn"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "series_statements", ["issn"], :name => "index_series_statements_on_issn"
  add_index "series_statements", ["root_manifestation_id"], :name => "index_series_statements_on_root_manifestation_id"
  add_index "series_statements", ["series_statement_identifier"], :name => "index_series_statements_on_series_statement_identifier"

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
