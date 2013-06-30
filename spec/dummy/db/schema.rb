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

ActiveRecord::Schema.define(:version => 20130509185724) do

  create_table "agent_import_files", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "state"
    t.string   "agent_import_file_name"
    t.string   "agent_import_content_type"
    t.integer  "agent_import_file_size"
    t.datetime "agent_import_updated_at"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "agent_import_fingerprint"
    t.text     "error_message"
    t.string   "edit_mode"
  end

  add_index "agent_import_files", ["parent_id"], :name => "index_agent_import_files_on_parent_id"
  add_index "agent_import_files", ["state"], :name => "index_agent_import_files_on_state"
  add_index "agent_import_files", ["user_id"], :name => "index_agent_import_files_on_user_id"

  create_table "agent_import_results", :force => true do |t|
    t.integer  "agent_import_file_id"
    t.integer  "agent_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "agent_relationship_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "agent_relationships", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "agent_relationship_type_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "position"
  end

  add_index "agent_relationships", ["child_id"], :name => "index_agent_relationships_on_child_id"
  add_index "agent_relationships", ["parent_id"], :name => "index_agent_relationships_on_parent_id"

  create_table "agent_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "agents", :force => true do |t|
    t.integer  "user_id"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "first_name"
    t.string   "last_name_transcription"
    t.string   "middle_name_transcription"
    t.string   "first_name_transcription"
    t.string   "corporate_name"
    t.string   "corporate_name_transcription"
    t.string   "full_name"
    t.text     "full_name_transcription"
    t.text     "full_name_alternative"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.datetime "deleted_at"
    t.string   "zip_code_1"
    t.string   "zip_code_2"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "address_1_note"
    t.text     "address_2_note"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number_1"
    t.string   "fax_number_2"
    t.text     "other_designation"
    t.text     "place"
    t.string   "postal_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.datetime "date_of_birth"
    t.datetime "date_of_death"
    t.integer  "language_id",                         :default => 1, :null => false
    t.integer  "country_id",                          :default => 1, :null => false
    t.integer  "agent_type_id",                       :default => 1, :null => false
    t.integer  "lock_version",                        :default => 0, :null => false
    t.text     "note"
    t.integer  "required_role_id",                    :default => 1, :null => false
    t.integer  "required_score",                      :default => 0, :null => false
    t.string   "state"
    t.text     "email"
    t.text     "url"
    t.text     "full_name_alternative_transcription"
    t.string   "birth_date"
    t.string   "death_date"
    t.string   "agent_identifier"
  end

  add_index "agents", ["agent_identifier"], :name => "index_agents_on_agent_identifier"
  add_index "agents", ["country_id"], :name => "index_agents_on_country_id"
  add_index "agents", ["full_name"], :name => "index_agents_on_full_name"
  add_index "agents", ["language_id"], :name => "index_agents_on_language_id"
  add_index "agents", ["required_role_id"], :name => "index_agents_on_required_role_id"
  add_index "agents", ["user_id"], :name => "index_agents_on_user_id", :unique => true

  create_table "carrier_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "classification_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "classifications", :force => true do |t|
    t.integer  "parent_id"
    t.string   "category",               :null => false
    t.text     "note"
    t.integer  "classification_type_id", :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "manifestation_id"
  end

  add_index "classifications", ["category"], :name => "index_classifications_on_category"
  add_index "classifications", ["classification_type_id"], :name => "index_classifications_on_classification_type_id"
  add_index "classifications", ["manifestation_id"], :name => "index_classifications_on_manifestation_id"
  add_index "classifications", ["parent_id"], :name => "index_classifications_on_parent_id"

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

  create_table "create_types", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "creates", :force => true do |t|
    t.integer  "agent_id",       :null => false
    t.integer  "work_id",        :null => false
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "create_type_id"
  end

  add_index "creates", ["agent_id"], :name => "index_creates_on_agent_id"
  add_index "creates", ["work_id"], :name => "index_creates_on_work_id"

  create_table "donates", :force => true do |t|
    t.integer  "agent_id",   :null => false
    t.integer  "item_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "donates", ["agent_id"], :name => "index_donates_on_agent_id"
  add_index "donates", ["item_id"], :name => "index_donates_on_item_id"

  create_table "exemplifies", :force => true do |t|
    t.integer  "manifestation_id", :null => false
    t.integer  "item_id",          :null => false
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "exemplifies", ["item_id"], :name => "index_exemplifies_on_item_id", :unique => true
  add_index "exemplifies", ["manifestation_id"], :name => "index_exemplifies_on_manifestation_id"

  create_table "extents", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "form_of_works", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "frequencies", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "identifier_types", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "identifiers", :force => true do |t|
    t.string   "body",               :null => false
    t.integer  "identifier_type_id", :null => false
    t.integer  "manifestation_id"
    t.boolean  "primary"
    t.integer  "position"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "identifiers", ["body", "identifier_type_id"], :name => "index_identifiers_on_body_and_identifier_type_id"
  add_index "identifiers", ["manifestation_id"], :name => "index_identifiers_on_manifestation_id"

  create_table "import_requests", :force => true do |t|
    t.string   "isbn"
    t.string   "state"
    t.integer  "manifestation_id"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "import_requests", ["isbn"], :name => "index_import_requests_on_isbn"
  add_index "import_requests", ["manifestation_id"], :name => "index_import_requests_on_manifestation_id"
  add_index "import_requests", ["user_id"], :name => "index_import_requests_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "call_number"
    t.string   "item_identifier"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.datetime "deleted_at"
    t.integer  "shelf_id",            :default => 1,     :null => false
    t.boolean  "include_supplements", :default => false, :null => false
    t.text     "note"
    t.string   "url"
    t.integer  "price"
    t.integer  "lock_version",        :default => 0,     :null => false
    t.integer  "required_role_id",    :default => 1,     :null => false
    t.string   "state"
    t.integer  "required_score",      :default => 0,     :null => false
    t.datetime "acquired_at"
    t.integer  "bookstore_id"
    t.integer  "budget_type_id"
  end

  add_index "items", ["bookstore_id"], :name => "index_items_on_bookstore_id"
  add_index "items", ["item_identifier"], :name => "index_items_on_item_identifier"
  add_index "items", ["required_role_id"], :name => "index_items_on_required_role_id"
  add_index "items", ["shelf_id"], :name => "index_items_on_shelf_id"

  create_table "languages", :force => true do |t|
    t.string  "name",         :null => false
    t.string  "native_name"
    t.text    "display_name"
    t.string  "iso_639_1"
    t.string  "iso_639_2"
    t.string  "iso_639_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "languages", ["iso_639_1"], :name => "index_languages_on_iso_639_1"
  add_index "languages", ["iso_639_2"], :name => "index_languages_on_iso_639_2"
  add_index "languages", ["iso_639_3"], :name => "index_languages_on_iso_639_3"
  add_index "languages", ["name"], :name => "index_languages_on_name", :unique => true

  create_table "licenses", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "manifestation_relationship_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "manifestation_relationships", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "manifestation_relationship_type_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "position"
  end

  add_index "manifestation_relationships", ["child_id"], :name => "index_manifestation_relationships_on_child_id"
  add_index "manifestation_relationships", ["parent_id"], :name => "index_manifestation_relationships_on_parent_id"

  create_table "manifestations", :force => true do |t|
    t.text     "original_title",                                     :null => false
    t.text     "title_alternative"
    t.text     "title_transcription"
    t.string   "classification_number"
    t.string   "manifestation_identifier"
    t.datetime "date_of_publication"
    t.datetime "date_copyrighted"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.datetime "deleted_at"
    t.string   "access_address"
    t.integer  "language_id",                     :default => 1,     :null => false
    t.integer  "carrier_type_id",                 :default => 1,     :null => false
    t.integer  "extent_id",                       :default => 1,     :null => false
    t.integer  "start_page"
    t.integer  "end_page"
    t.integer  "height"
    t.integer  "width"
    t.integer  "depth"
    t.integer  "price"
    t.text     "fulltext"
    t.string   "volume_number_string"
    t.string   "issue_number_string"
    t.string   "serial_number_string"
    t.integer  "edition"
    t.text     "note"
    t.boolean  "repository_content",              :default => false, :null => false
    t.integer  "lock_version",                    :default => 0,     :null => false
    t.integer  "required_role_id",                :default => 1,     :null => false
    t.string   "state"
    t.integer  "required_score",                  :default => 0,     :null => false
    t.integer  "frequency_id",                    :default => 1,     :null => false
    t.boolean  "subscription_master",             :default => false, :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "title_alternative_transcription"
    t.text     "description"
    t.text     "abstract"
    t.datetime "available_at"
    t.datetime "valid_until"
    t.datetime "date_submitted"
    t.datetime "date_accepted"
    t.datetime "date_caputured"
    t.string   "pub_date"
    t.string   "edition_string"
    t.integer  "volume_number"
    t.integer  "issue_number"
    t.integer  "serial_number"
    t.string   "ndc"
    t.integer  "content_type_id",                 :default => 1
    t.integer  "year_of_publication"
    t.text     "attachment_meta"
    t.integer  "month_of_publication"
    t.string   "doi"
    t.boolean  "periodical"
    t.text     "statement_of_responsibility"
  end

  add_index "manifestations", ["access_address"], :name => "index_manifestations_on_access_address"
  add_index "manifestations", ["carrier_type_id"], :name => "index_manifestations_on_carrier_type_id"
  add_index "manifestations", ["doi"], :name => "index_manifestations_on_doi"
  add_index "manifestations", ["frequency_id"], :name => "index_manifestations_on_frequency_id"
  add_index "manifestations", ["manifestation_identifier"], :name => "index_manifestations_on_manifestation_identifier"
  add_index "manifestations", ["required_role_id"], :name => "index_manifestations_on_required_role_id"
  add_index "manifestations", ["updated_at"], :name => "index_manifestations_on_updated_at"

  create_table "medium_of_performances", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "owns", :force => true do |t|
    t.integer  "agent_id",   :null => false
    t.integer  "item_id",    :null => false
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "owns", ["agent_id"], :name => "index_owns_on_agent_id"
  add_index "owns", ["item_id"], :name => "index_owns_on_item_id"

  create_table "picture_files", :force => true do |t|
    t.integer  "picture_attachable_id"
    t.string   "picture_attachable_type"
    t.string   "content_type"
    t.text     "title"
    t.string   "thumbnail"
    t.integer  "position"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "picture_meta"
    t.string   "picture_fingerprint"
  end

  add_index "picture_files", ["picture_attachable_id", "picture_attachable_type"], :name => "index_picture_files_on_picture_attachable_id_and_type"

  create_table "produce_types", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "produces", :force => true do |t|
    t.integer  "agent_id",         :null => false
    t.integer  "manifestation_id", :null => false
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "produce_type_id"
  end

  add_index "produces", ["agent_id"], :name => "index_produces_on_agent_id"
  add_index "produces", ["manifestation_id"], :name => "index_produces_on_manifestation_id"

  create_table "realize_types", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "realizes", :force => true do |t|
    t.integer  "agent_id",        :null => false
    t.integer  "expression_id",   :null => false
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "realize_type_id"
  end

  add_index "realizes", ["agent_id"], :name => "index_realizes_on_agent_id"
  add_index "realizes", ["expression_id"], :name => "index_realizes_on_expression_id"

  create_table "resource_import_files", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "state"
    t.string   "resource_import_file_name"
    t.string   "resource_import_content_type"
    t.integer  "resource_import_file_size"
    t.datetime "resource_import_updated_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "edit_mode"
    t.string   "resource_import_fingerprint"
    t.text     "error_message"
  end

  add_index "resource_import_files", ["parent_id"], :name => "index_resource_import_files_on_parent_id"
  add_index "resource_import_files", ["state"], :name => "index_resource_import_files_on_state"
  add_index "resource_import_files", ["user_id"], :name => "index_resource_import_files_on_user_id"

  create_table "resource_import_results", :force => true do |t|
    t.integer  "resource_import_file_id"
    t.integer  "manifestation_id"
    t.integer  "item_id"
    t.text     "body"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "resource_import_results", ["item_id"], :name => "index_resource_import_results_on_item_id"
  add_index "resource_import_results", ["manifestation_id"], :name => "index_resource_import_results_on_manifestation_id"
  add_index "resource_import_results", ["resource_import_file_id"], :name => "index_resource_import_results_on_resource_import_file_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
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
    t.text     "numbering"
    t.text     "title_subseries"
    t.text     "numbering_subseries"
    t.integer  "position"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.text     "title_transcription"
    t.text     "title_alternative"
    t.string   "series_statement_identifier"
    t.string   "issn"
    t.boolean  "periodical"
    t.integer  "manifestation_id"
    t.text     "note"
    t.text     "title_subseries_transcription"
    t.text     "creator_string"
    t.text     "volume_number_string"
    t.text     "volume_number_transcription_string"
    t.boolean  "series_master"
  end

  add_index "series_statements", ["manifestation_id"], :name => "index_series_statements_on_manifestation_id"
  add_index "series_statements", ["series_statement_identifier"], :name => "index_series_statements_on_series_statement_identifier"

  create_table "subject_has_classifications", :force => true do |t|
    t.integer  "subject_id"
    t.string   "subject_type"
    t.integer  "classification_id", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "subject_has_classifications", ["classification_id"], :name => "index_subject_has_classifications_on_classification_id"
  add_index "subject_has_classifications", ["subject_id"], :name => "index_subject_has_classifications_on_subject_id"

  create_table "subject_heading_type_has_subjects", :force => true do |t|
    t.integer  "subject_id",              :null => false
    t.string   "subject_type"
    t.integer  "subject_heading_type_id", :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "subject_heading_type_has_subjects", ["subject_id"], :name => "index_subject_heading_type_has_subjects_on_subject_id"

  create_table "subject_heading_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "subject_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "subjects", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "use_term_id"
    t.string   "term"
    t.text     "term_transcription"
    t.integer  "subject_type_id",                        :null => false
    t.text     "scope_note"
    t.text     "note"
    t.integer  "required_role_id",        :default => 1, :null => false
    t.integer  "lock_version",            :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "url"
    t.integer  "manifestation_id"
    t.integer  "subject_heading_type_id"
  end

  add_index "subjects", ["manifestation_id"], :name => "index_subjects_on_manifestation_id"
  add_index "subjects", ["parent_id"], :name => "index_subjects_on_parent_id"
  add_index "subjects", ["required_role_id"], :name => "index_subjects_on_required_role_id"
  add_index "subjects", ["subject_type_id"], :name => "index_subjects_on_subject_type_id"
  add_index "subjects", ["term"], :name => "index_subjects_on_term"
  add_index "subjects", ["use_term_id"], :name => "index_subjects_on_use_term_id"

  create_table "user_has_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "user_group_id"
    t.integer  "required_role_id"
    t.string   "username"
    t.text     "note"
    t.string   "locale"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "work_has_subjects", :force => true do |t|
    t.integer  "subject_id"
    t.string   "subject_type"
    t.integer  "work_id"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "work_has_subjects", ["subject_id"], :name => "index_work_has_subjects_on_subject_id"
  add_index "work_has_subjects", ["work_id"], :name => "index_work_has_subjects_on_work_id"

end
