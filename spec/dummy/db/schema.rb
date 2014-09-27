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

ActiveRecord::Schema.define(version: 20140823095740) do

  create_table "agent_import_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",             default: "{}"
    t.integer  "sort_key"
    t.integer  "agent_import_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agent_import_file_transitions", ["agent_import_file_id"], name: "index_agent_import_file_transitions_on_agent_import_file_id"
  add_index "agent_import_file_transitions", ["sort_key", "agent_import_file_id"], name: "index_agent_import_file_transitions_on_sort_key_and_file_id", unique: true

  create_table "agent_import_files", force: true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "agent_import_file_name"
    t.string   "agent_import_content_type"
    t.integer  "agent_import_file_size"
    t.datetime "agent_import_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "agent_import_fingerprint"
    t.text     "error_message"
    t.string   "edit_mode"
    t.string   "user_encoding"
  end

  add_index "agent_import_files", ["parent_id"], name: "index_agent_import_files_on_parent_id"
  add_index "agent_import_files", ["user_id"], name: "index_agent_import_files_on_user_id"

  create_table "agent_import_results", force: true do |t|
    t.integer  "agent_import_file_id"
    t.integer  "agent_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agent_merge_lists", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agent_merges", force: true do |t|
    t.integer  "agent_id",            null: false
    t.integer  "agent_merge_list_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agent_merges", ["agent_id"], name: "index_agent_merges_on_agent_id"
  add_index "agent_merges", ["agent_merge_list_id"], name: "index_agent_merges_on_agent_merge_list_id"

  create_table "agent_relationship_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agent_relationships", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "agent_relationship_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "agent_relationships", ["child_id"], name: "index_agent_relationships_on_child_id"
  add_index "agent_relationships", ["parent_id"], name: "index_agent_relationships_on_parent_id"

  create_table "agent_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "language_id",                         default: 1, null: false
    t.integer  "country_id",                          default: 1, null: false
    t.integer  "agent_type_id",                       default: 1, null: false
    t.integer  "lock_version",                        default: 0, null: false
    t.text     "note"
    t.integer  "required_role_id",                    default: 1, null: false
    t.integer  "required_score",                      default: 0, null: false
    t.text     "email"
    t.text     "url"
    t.text     "full_name_alternative_transcription"
    t.string   "birth_date"
    t.string   "death_date"
    t.string   "agent_identifier"
  end

  add_index "agents", ["agent_identifier"], name: "index_agents_on_agent_identifier"
  add_index "agents", ["country_id"], name: "index_agents_on_country_id"
  add_index "agents", ["full_name"], name: "index_agents_on_full_name"
  add_index "agents", ["language_id"], name: "index_agents_on_language_id"
  add_index "agents", ["required_role_id"], name: "index_agents_on_required_role_id"

  create_table "carrier_type_has_checkout_types", force: true do |t|
    t.integer  "carrier_type_id",  null: false
    t.integer  "checkout_type_id", null: false
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carrier_type_has_checkout_types", ["carrier_type_id"], name: "index_carrier_type_has_checkout_types_on_m_form_id"
  add_index "carrier_type_has_checkout_types", ["checkout_type_id"], name: "index_carrier_type_has_checkout_types_on_checkout_type_id"

  create_table "carrier_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checked_items", force: true do |t|
    t.integer  "item_id",      null: false
    t.integer  "basket_id",    null: false
    t.datetime "due_date",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "librarian_id"
  end

  add_index "checked_items", ["basket_id"], name: "index_checked_items_on_basket_id"
  add_index "checked_items", ["item_id"], name: "index_checked_items_on_item_id"

  create_table "checkins", force: true do |t|
    t.integer  "item_id",                  null: false
    t.integer  "librarian_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", default: 0, null: false
  end

  add_index "checkins", ["basket_id"], name: "index_checkins_on_basket_id"
  add_index "checkins", ["item_id"], name: "index_checkins_on_item_id"
  add_index "checkins", ["librarian_id"], name: "index_checkins_on_librarian_id"

  create_table "checkout_stat_has_manifestations", force: true do |t|
    t.integer  "manifestation_checkout_stat_id", null: false
    t.integer  "manifestation_id",               null: false
    t.integer  "checkouts_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_stat_has_manifestations", ["manifestation_checkout_stat_id"], name: "index_checkout_stat_has_manifestations_on_checkout_stat_id"
  add_index "checkout_stat_has_manifestations", ["manifestation_id"], name: "index_checkout_stat_has_manifestations_on_manifestation_id"

  create_table "checkout_stat_has_users", force: true do |t|
    t.integer  "user_checkout_stat_id",             null: false
    t.integer  "user_id",                           null: false
    t.integer  "checkouts_count",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_stat_has_users", ["user_checkout_stat_id"], name: "index_checkout_stat_has_users_on_user_checkout_stat_id"
  add_index "checkout_stat_has_users", ["user_id"], name: "index_checkout_stat_has_users_on_user_id"

  create_table "checkout_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_types", ["name"], name: "index_checkout_types_on_name"

  create_table "checkouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id",                            null: false
    t.integer  "checkin_id"
    t.integer  "librarian_id"
    t.integer  "basket_id"
    t.datetime "due_date"
    t.integer  "checkout_renewal_count", default: 0, null: false
    t.integer  "lock_version",           default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkouts", ["basket_id"], name: "index_checkouts_on_basket_id"
  add_index "checkouts", ["checkin_id"], name: "index_checkouts_on_checkin_id"
  add_index "checkouts", ["item_id", "basket_id"], name: "index_checkouts_on_item_id_and_basket_id", unique: true
  add_index "checkouts", ["item_id"], name: "index_checkouts_on_item_id"
  add_index "checkouts", ["librarian_id"], name: "index_checkouts_on_librarian_id"
  add_index "checkouts", ["user_id"], name: "index_checkouts_on_user_id"

  create_table "circulation_statuses", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classification_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications", force: true do |t|
    t.integer  "parent_id"
    t.string   "category",               null: false
    t.text     "note"
    t.integer  "classification_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "manifestation_id"
  end

  add_index "classifications", ["category"], name: "index_classifications_on_category"
  add_index "classifications", ["classification_type_id"], name: "index_classifications_on_classification_type_id"
  add_index "classifications", ["manifestation_id"], name: "index_classifications_on_manifestation_id"
  add_index "classifications", ["parent_id"], name: "index_classifications_on_parent_id"

  create_table "content_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string  "name",         null: false
    t.text    "display_name"
    t.string  "alpha_2"
    t.string  "alpha_3"
    t.string  "numeric_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "countries", ["alpha_2"], name: "index_countries_on_alpha_2"
  add_index "countries", ["alpha_3"], name: "index_countries_on_alpha_3"
  add_index "countries", ["name"], name: "index_countries_on_name"
  add_index "countries", ["numeric_3"], name: "index_countries_on_numeric_3"

  create_table "create_types", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creates", force: true do |t|
    t.integer  "agent_id",       null: false
    t.integer  "work_id",        null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "create_type_id"
  end

  add_index "creates", ["agent_id"], name: "index_creates_on_agent_id"
  add_index "creates", ["work_id"], name: "index_creates_on_work_id"

  create_table "donates", force: true do |t|
    t.integer  "agent_id",   null: false
    t.integer  "item_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donates", ["agent_id"], name: "index_donates_on_agent_id"
  add_index "donates", ["item_id"], name: "index_donates_on_item_id"

  create_table "event_categories", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_import_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",             default: "{}"
    t.integer  "sort_key"
    t.integer  "event_import_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_import_file_transitions", ["event_import_file_id"], name: "index_event_import_file_transitions_on_event_import_file_id"
  add_index "event_import_file_transitions", ["sort_key", "event_import_file_id"], name: "index_event_import_file_transitions_on_sort_key_and_file_id", unique: true

  create_table "event_import_files", force: true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "event_import_file_name"
    t.string   "event_import_content_type"
    t.integer  "event_import_file_size"
    t.datetime "event_import_updated_at"
    t.string   "edit_mode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_import_fingerprint"
    t.text     "error_message"
    t.string   "user_encoding"
    t.integer  "default_library_id"
  end

  add_index "event_import_files", ["parent_id"], name: "index_event_import_files_on_parent_id"
  add_index "event_import_files", ["user_id"], name: "index_event_import_files_on_user_id"

  create_table "event_import_results", force: true do |t|
    t.integer  "event_import_file_id"
    t.integer  "event_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "library_id",        default: 1,     null: false
    t.integer  "event_category_id", default: 1,     null: false
    t.string   "name"
    t.text     "note"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day",           default: false, null: false
    t.datetime "deleted_at"
    t.text     "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_category_id"], name: "index_events_on_event_category_id"
  add_index "events", ["library_id"], name: "index_events_on_library_id"

  create_table "exemplifies", force: true do |t|
    t.integer  "manifestation_id", null: false
    t.integer  "item_id",          null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exemplifies", ["item_id"], name: "index_exemplifies_on_item_id", unique: true
  add_index "exemplifies", ["manifestation_id"], name: "index_exemplifies_on_manifestation_id"

  create_table "extents", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_of_works", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frequencies", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identifier_types", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identifiers", force: true do |t|
    t.string   "body",               null: false
    t.integer  "identifier_type_id", null: false
    t.integer  "manifestation_id"
    t.boolean  "primary"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identifiers", ["body", "identifier_type_id"], name: "index_identifiers_on_body_and_identifier_type_id"
  add_index "identifiers", ["manifestation_id"], name: "index_identifiers_on_manifestation_id"

  create_table "import_request_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",          default: "{}"
    t.integer  "sort_key"
    t.integer  "import_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "import_request_transitions", ["import_request_id"], name: "index_import_request_transitions_on_import_request_id"
  add_index "import_request_transitions", ["sort_key", "import_request_id"], name: "index_import_request_transitions_on_sort_key_and_request_id", unique: true

  create_table "import_requests", force: true do |t|
    t.string   "isbn"
    t.integer  "manifestation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "import_requests", ["isbn"], name: "index_import_requests_on_isbn"
  add_index "import_requests", ["manifestation_id"], name: "index_import_requests_on_manifestation_id"
  add_index "import_requests", ["user_id"], name: "index_import_requests_on_user_id"

  create_table "item_has_use_restrictions", force: true do |t|
    t.integer  "item_id",            null: false
    t.integer  "use_restriction_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_has_use_restrictions", ["item_id"], name: "index_item_has_use_restrictions_on_item_id"
  add_index "item_has_use_restrictions", ["use_restriction_id"], name: "index_item_has_use_restrictions_on_use_restriction_id"

  create_table "items", force: true do |t|
    t.string   "call_number"
    t.string   "item_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "shelf_id",                default: 1,     null: false
    t.boolean  "include_supplements",     default: false, null: false
    t.text     "note"
    t.string   "url"
    t.integer  "price"
    t.integer  "lock_version",            default: 0,     null: false
    t.integer  "required_role_id",        default: 1,     null: false
    t.integer  "required_score",          default: 0,     null: false
    t.datetime "acquired_at"
    t.integer  "bookstore_id"
    t.integer  "budget_type_id"
    t.integer  "circulation_status_id",   default: 5,     null: false
    t.integer  "checkout_type_id",        default: 1,     null: false
    t.string   "binding_item_identifier"
    t.string   "binding_call_number"
    t.datetime "binded_at"
    t.integer  "manifestation_id"
  end

  add_index "items", ["binding_item_identifier"], name: "index_items_on_binding_item_identifier"
  add_index "items", ["bookstore_id"], name: "index_items_on_bookstore_id"
  add_index "items", ["checkout_type_id"], name: "index_items_on_checkout_type_id"
  add_index "items", ["circulation_status_id"], name: "index_items_on_circulation_status_id"
  add_index "items", ["item_identifier"], name: "index_items_on_item_identifier"
  add_index "items", ["manifestation_id"], name: "index_items_on_manifestation_id"
  add_index "items", ["required_role_id"], name: "index_items_on_required_role_id"
  add_index "items", ["shelf_id"], name: "index_items_on_shelf_id"

  create_table "languages", force: true do |t|
    t.string  "name",         null: false
    t.string  "native_name"
    t.text    "display_name"
    t.string  "iso_639_1"
    t.string  "iso_639_2"
    t.string  "iso_639_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "languages", ["iso_639_1"], name: "index_languages_on_iso_639_1"
  add_index "languages", ["iso_639_2"], name: "index_languages_on_iso_639_2"
  add_index "languages", ["iso_639_3"], name: "index_languages_on_iso_639_3"
  add_index "languages", ["name"], name: "index_languages_on_name", unique: true

  create_table "lending_policies", force: true do |t|
    t.integer  "item_id",                    null: false
    t.integer  "user_group_id",              null: false
    t.integer  "loan_period",    default: 0, null: false
    t.datetime "fixed_due_date"
    t.integer  "renewal",        default: 0, null: false
    t.integer  "fine",           default: 0, null: false
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lending_policies", ["item_id", "user_group_id"], name: "index_lending_policies_on_item_id_and_user_group_id", unique: true

  create_table "licenses", force: true do |t|
    t.string   "name",         null: false
    t.string   "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manifestation_checkout_stat_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",                       default: "{}"
    t.integer  "sort_key"
    t.integer  "manifestation_checkout_stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manifestation_checkout_stat_transitions", ["manifestation_checkout_stat_id"], name: "index_manifestation_checkout_stat_transitions_on_stat_id"
  add_index "manifestation_checkout_stat_transitions", ["sort_key", "manifestation_checkout_stat_id"], name: "index_manifestation_checkout_stat_transitions_on_transition", unique: true

  create_table "manifestation_checkout_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "user_id"
  end

  add_index "manifestation_checkout_stats", ["user_id"], name: "index_manifestation_checkout_stats_on_user_id"

  create_table "manifestation_relationship_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manifestation_relationships", force: true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.integer  "manifestation_relationship_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "manifestation_relationships", ["child_id"], name: "index_manifestation_relationships_on_child_id"
  add_index "manifestation_relationships", ["parent_id"], name: "index_manifestation_relationships_on_parent_id"

  create_table "manifestation_reserve_stat_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",                      default: "{}"
    t.integer  "sort_key"
    t.integer  "manifestation_reserve_stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manifestation_reserve_stat_transitions", ["manifestation_reserve_stat_id"], name: "index_manifestation_reserve_stat_transitions_on_stat_id"
  add_index "manifestation_reserve_stat_transitions", ["sort_key", "manifestation_reserve_stat_id"], name: "index_manifestation_reserve_stat_transitions_on_transition", unique: true

  create_table "manifestation_reserve_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "user_id"
  end

  add_index "manifestation_reserve_stats", ["user_id"], name: "index_manifestation_reserve_stats_on_user_id"

  create_table "manifestations", force: true do |t|
    t.text     "original_title",                                  null: false
    t.text     "title_alternative"
    t.text     "title_transcription"
    t.string   "classification_number"
    t.string   "manifestation_identifier"
    t.datetime "date_of_publication"
    t.datetime "date_copyrighted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "access_address"
    t.integer  "language_id",                     default: 1,     null: false
    t.integer  "carrier_type_id",                 default: 1,     null: false
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
    t.boolean  "repository_content",              default: false, null: false
    t.integer  "lock_version",                    default: 0,     null: false
    t.integer  "required_role_id",                default: 1,     null: false
    t.integer  "required_score",                  default: 0,     null: false
    t.integer  "frequency_id",                    default: 1,     null: false
    t.boolean  "subscription_master",             default: false, null: false
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
    t.integer  "content_type_id",                 default: 1
    t.integer  "year_of_publication"
    t.text     "attachment_meta"
    t.integer  "month_of_publication"
    t.boolean  "fulltext_content"
    t.string   "doi"
    t.boolean  "serial"
    t.text     "statement_of_responsibility"
    t.text     "publication_place"
    t.text     "extent"
    t.text     "dimensions"
  end

  add_index "manifestations", ["access_address"], name: "index_manifestations_on_access_address"
  add_index "manifestations", ["date_of_publication"], name: "index_manifestations_on_date_of_publication"
  add_index "manifestations", ["doi"], name: "index_manifestations_on_doi"
  add_index "manifestations", ["manifestation_identifier"], name: "index_manifestations_on_manifestation_identifier"
  add_index "manifestations", ["updated_at"], name: "index_manifestations_on_updated_at"

  create_table "medium_of_performances", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_request_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",           default: "{}"
    t.integer  "sort_key"
    t.integer  "message_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_request_transitions", ["message_request_id"], name: "index_message_request_transitions_on_message_request_id"
  add_index "message_request_transitions", ["sort_key", "message_request_id"], name: "index_message_request_transitions_on_sort_key_and_request_id", unique: true

  create_table "message_requests", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "message_template_id"
    t.datetime "sent_at"
    t.datetime "deleted_at"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_templates", force: true do |t|
    t.string   "status",                    null: false
    t.text     "title",                     null: false
    t.text     "body",                      null: false
    t.integer  "position"
    t.string   "locale",     default: "en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_templates", ["status"], name: "index_message_templates_on_status", unique: true

  create_table "message_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",   default: "{}"
    t.integer  "sort_key"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_transitions", ["message_id"], name: "index_message_transitions_on_message_id"
  add_index "message_transitions", ["sort_key", "message_id"], name: "index_message_transitions_on_sort_key_and_message_id", unique: true

  create_table "messages", force: true do |t|
    t.datetime "read_at"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "subject",            null: false
    t.text     "body"
    t.integer  "message_request_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  add_index "messages", ["message_request_id"], name: "index_messages_on_message_request_id"
  add_index "messages", ["parent_id"], name: "index_messages_on_parent_id"
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "owns", force: true do |t|
    t.integer  "agent_id",   null: false
    t.integer  "item_id",    null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "owns", ["agent_id"], name: "index_owns_on_agent_id"
  add_index "owns", ["item_id"], name: "index_owns_on_item_id"

  create_table "participates", force: true do |t|
    t.integer  "agent_id",   null: false
    t.integer  "event_id",   null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participates", ["agent_id"], name: "index_participates_on_agent_id"
  add_index "participates", ["event_id"], name: "index_participates_on_event_id"

  create_table "picture_files", force: true do |t|
    t.integer  "picture_attachable_id"
    t.string   "picture_attachable_type"
    t.string   "content_type"
    t.text     "title"
    t.string   "thumbnail"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "picture_meta"
    t.string   "picture_fingerprint"
  end

  add_index "picture_files", ["picture_attachable_id", "picture_attachable_type"], name: "index_picture_files_on_picture_attachable_id_and_type"

  create_table "produce_types", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produces", force: true do |t|
    t.integer  "agent_id",         null: false
    t.integer  "manifestation_id", null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "produce_type_id"
  end

  add_index "produces", ["agent_id"], name: "index_produces_on_agent_id"
  add_index "produces", ["manifestation_id"], name: "index_produces_on_manifestation_id"

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_group_id"
    t.integer  "library_id"
    t.string   "locale"
    t.string   "user_number"
    t.text     "full_name"
    t.text     "note"
    t.text     "keyword_list"
    t.integer  "required_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "checkout_icalendar_token"
    t.boolean  "save_checkout_history",    default: false, null: false
    t.datetime "expired_at"
  end

  add_index "profiles", ["checkout_icalendar_token"], name: "index_profiles_on_checkout_icalendar_token", unique: true
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"
  add_index "profiles", ["user_number"], name: "index_profiles_on_user_number", unique: true

  create_table "realize_types", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "realizes", force: true do |t|
    t.integer  "agent_id",        null: false
    t.integer  "expression_id",   null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "realize_type_id"
  end

  add_index "realizes", ["agent_id"], name: "index_realizes_on_agent_id"
  add_index "realizes", ["expression_id"], name: "index_realizes_on_expression_id"

  create_table "reserve_stat_has_manifestations", force: true do |t|
    t.integer  "manifestation_reserve_stat_id", null: false
    t.integer  "manifestation_id",              null: false
    t.integer  "reserves_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserve_stat_has_manifestations", ["manifestation_id"], name: "index_reserve_stat_has_manifestations_on_manifestation_id"
  add_index "reserve_stat_has_manifestations", ["manifestation_reserve_stat_id"], name: "index_reserve_stat_has_manifestations_on_m_reserve_stat_id"

  create_table "reserve_stat_has_users", force: true do |t|
    t.integer  "user_reserve_stat_id", null: false
    t.integer  "user_id",              null: false
    t.integer  "reserves_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserve_stat_has_users", ["user_id"], name: "index_reserve_stat_has_users_on_user_id"
  add_index "reserve_stat_has_users", ["user_reserve_stat_id"], name: "index_reserve_stat_has_users_on_user_reserve_stat_id"

  create_table "reserve_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",   default: "{}"
    t.integer  "sort_key"
    t.integer  "reserve_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserve_transitions", ["reserve_id"], name: "index_reserve_transitions_on_reserve_id"
  add_index "reserve_transitions", ["sort_key", "reserve_id"], name: "index_reserve_transitions_on_sort_key_and_reserve_id", unique: true

  create_table "reserves", force: true do |t|
    t.integer  "user_id",                                      null: false
    t.integer  "manifestation_id",                             null: false
    t.integer  "item_id"
    t.integer  "request_status_type_id",                       null: false
    t.datetime "checked_out_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "canceled_at"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.boolean  "expiration_notice_to_patron",  default: false
    t.boolean  "expiration_notice_to_library", default: false
    t.datetime "retained_at"
    t.datetime "postponed_at"
    t.integer  "lock_version",                 default: 0,     null: false
  end

  add_index "reserves", ["item_id"], name: "index_reserves_on_item_id"
  add_index "reserves", ["manifestation_id"], name: "index_reserves_on_manifestation_id"
  add_index "reserves", ["request_status_type_id"], name: "index_reserves_on_request_status_type_id"
  add_index "reserves", ["state"], name: "index_reserves_on_state"
  add_index "reserves", ["user_id"], name: "index_reserves_on_user_id"

  create_table "resource_export_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",                default: "{}"
    t.integer  "sort_key"
    t.integer  "resource_export_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_export_file_transitions", ["resource_export_file_id"], name: "index_resource_export_file_transitions_on_file_id"
  add_index "resource_export_file_transitions", ["sort_key", "resource_export_file_id"], name: "index_resource_export_file_transitions_on_sort_key_and_file_id", unique: true

  create_table "resource_export_files", force: true do |t|
    t.integer  "user_id"
    t.string   "resource_export_file_name"
    t.string   "resource_export_content_type"
    t.integer  "resource_export_file_size"
    t.datetime "resource_export_updated_at"
    t.datetime "executed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_import_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",                default: "{}"
    t.integer  "sort_key"
    t.integer  "resource_import_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_import_file_transitions", ["resource_import_file_id"], name: "index_resource_import_file_transitions_on_file_id"
  add_index "resource_import_file_transitions", ["sort_key", "resource_import_file_id"], name: "index_resource_import_file_transitions_on_sort_key_and_file_id", unique: true

  create_table "resource_import_files", force: true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "resource_import_file_name"
    t.string   "resource_import_content_type"
    t.integer  "resource_import_file_size"
    t.datetime "resource_import_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edit_mode"
    t.string   "resource_import_fingerprint"
    t.text     "error_message"
    t.string   "user_encoding"
    t.integer  "default_shelf_id"
  end

  add_index "resource_import_files", ["parent_id"], name: "index_resource_import_files_on_parent_id"
  add_index "resource_import_files", ["user_id"], name: "index_resource_import_files_on_user_id"

  create_table "resource_import_results", force: true do |t|
    t.integer  "resource_import_file_id"
    t.integer  "manifestation_id"
    t.integer  "item_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "error_message"
  end

  add_index "resource_import_results", ["item_id"], name: "index_resource_import_results_on_item_id"
  add_index "resource_import_results", ["manifestation_id"], name: "index_resource_import_results_on_manifestation_id"
  add_index "resource_import_results", ["resource_import_file_id"], name: "index_resource_import_results_on_resource_import_file_id"

  create_table "roles", force: true do |t|
    t.string   "name",                     null: false
    t.string   "display_name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",        default: 0, null: false
    t.integer  "position"
  end

  create_table "series_statement_merge_lists", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_statement_merges", force: true do |t|
    t.integer  "series_statement_id",            null: false
    t.integer  "series_statement_merge_list_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "series_statement_merges", ["series_statement_id"], name: "index_series_statement_merges_on_series_statement_id"
  add_index "series_statement_merges", ["series_statement_merge_list_id"], name: "index_series_statement_merges_on_list_id"

  create_table "series_statements", force: true do |t|
    t.text     "original_title"
    t.text     "numbering"
    t.text     "title_subseries"
    t.text     "numbering_subseries"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "title_transcription"
    t.text     "title_alternative"
    t.string   "series_statement_identifier"
    t.integer  "manifestation_id"
    t.text     "note"
    t.text     "title_subseries_transcription"
    t.text     "creator_string"
    t.text     "volume_number_string"
    t.text     "volume_number_transcription_string"
    t.boolean  "series_master"
    t.integer  "root_manifestation_id"
  end

  add_index "series_statements", ["manifestation_id"], name: "index_series_statements_on_manifestation_id"
  add_index "series_statements", ["root_manifestation_id"], name: "index_series_statements_on_root_manifestation_id"
  add_index "series_statements", ["series_statement_identifier"], name: "index_series_statements_on_series_statement_identifier"

  create_table "subject_heading_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.integer  "parent_id"
    t.integer  "use_term_id"
    t.string   "term"
    t.text     "term_transcription"
    t.integer  "subject_type_id",                     null: false
    t.text     "scope_note"
    t.text     "note"
    t.integer  "required_role_id",        default: 1, null: false
    t.integer  "lock_version",            default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "url"
    t.integer  "manifestation_id"
    t.integer  "subject_heading_type_id"
  end

  add_index "subjects", ["manifestation_id"], name: "index_subjects_on_manifestation_id"
  add_index "subjects", ["parent_id"], name: "index_subjects_on_parent_id"
  add_index "subjects", ["required_role_id"], name: "index_subjects_on_required_role_id"
  add_index "subjects", ["subject_type_id"], name: "index_subjects_on_subject_type_id"
  add_index "subjects", ["term"], name: "index_subjects_on_term"
  add_index "subjects", ["use_term_id"], name: "index_subjects_on_use_term_id"

  create_table "use_restrictions", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_checkout_stat_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",              default: "{}"
    t.integer  "sort_key"
    t.integer  "user_checkout_stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_checkout_stat_transitions", ["sort_key", "user_checkout_stat_id"], name: "index_user_checkout_stat_transitions_on_sort_key_and_stat_id", unique: true
  add_index "user_checkout_stat_transitions", ["user_checkout_stat_id"], name: "index_user_checkout_stat_transitions_on_user_checkout_stat_id"

  create_table "user_checkout_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "user_id"
  end

  add_index "user_checkout_stats", ["user_id"], name: "index_user_checkout_stats_on_user_id"

  create_table "user_export_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",            default: "{}"
    t.integer  "sort_key"
    t.integer  "user_export_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_export_file_transitions", ["sort_key", "user_export_file_id"], name: "index_user_export_file_transitions_on_sort_key_and_file_id", unique: true
  add_index "user_export_file_transitions", ["user_export_file_id"], name: "index_user_export_file_transitions_on_file_id"

  create_table "user_export_files", force: true do |t|
    t.integer  "user_id"
    t.string   "user_export_file_name"
    t.string   "user_export_content_type"
    t.integer  "user_export_file_size"
    t.datetime "user_export_updated_at"
    t.datetime "executed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_group_has_checkout_types", force: true do |t|
    t.integer  "user_group_id",                                   null: false
    t.integer  "checkout_type_id",                                null: false
    t.integer  "checkout_limit",                  default: 0,     null: false
    t.integer  "checkout_period",                 default: 0,     null: false
    t.integer  "checkout_renewal_limit",          default: 0,     null: false
    t.integer  "reservation_limit",               default: 0,     null: false
    t.integer  "reservation_expired_period",      default: 7,     null: false
    t.boolean  "set_due_date_before_closing_day", default: false, null: false
    t.datetime "fixed_due_date"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_checkout_count"
  end

  add_index "user_group_has_checkout_types", ["checkout_type_id"], name: "index_user_group_has_checkout_types_on_checkout_type_id"
  add_index "user_group_has_checkout_types", ["user_group_id"], name: "index_user_group_has_checkout_types_on_user_group_id"

  create_table "user_groups", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "valid_period_for_new_user",        default: 0, null: false
    t.datetime "expired_at"
    t.integer  "number_of_day_to_notify_overdue",  default: 1, null: false
    t.integer  "number_of_day_to_notify_due_date", default: 7, null: false
    t.integer  "number_of_time_to_notify_overdue", default: 3, null: false
  end

  create_table "user_has_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_has_roles", ["role_id"], name: "index_user_has_roles_on_role_id"
  add_index "user_has_roles", ["user_id"], name: "index_user_has_roles_on_user_id"

  create_table "user_import_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",            default: "{}"
    t.integer  "sort_key"
    t.integer  "user_import_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_import_file_transitions", ["sort_key", "user_import_file_id"], name: "index_user_import_file_transitions_on_sort_key_and_file_id", unique: true
  add_index "user_import_file_transitions", ["user_import_file_id"], name: "index_user_import_file_transitions_on_user_import_file_id"

  create_table "user_import_files", force: true do |t|
    t.integer  "user_id"
    t.text     "note"
    t.datetime "executed_at"
    t.string   "user_import_file_name"
    t.string   "user_import_content_type"
    t.string   "user_import_file_size"
    t.datetime "user_import_updated_at"
    t.string   "user_import_fingerprint"
    t.string   "edit_mode"
    t.text     "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_encoding"
    t.integer  "default_library_id"
    t.integer  "default_user_group_id"
  end

  create_table "user_import_results", force: true do |t|
    t.integer  "user_import_file_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_reserve_stat_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",             default: "{}"
    t.integer  "sort_key"
    t.integer  "user_reserve_stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_reserve_stat_transitions", ["sort_key", "user_reserve_stat_id"], name: "index_user_reserve_stat_transitions_on_sort_key_and_stat_id", unique: true
  add_index "user_reserve_stat_transitions", ["user_reserve_stat_id"], name: "index_user_reserve_stat_transitions_on_user_reserve_stat_id"

  create_table "user_reserve_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "user_id"
  end

  add_index "user_reserve_stats", ["user_id"], name: "index_user_reserve_stats_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "save_checkout_history",    default: false, null: false
    t.string   "checkout_icalendar_token"
    t.string   "username"
    t.datetime "deleted_at"
    t.datetime "expired_at"
    t.integer  "failed_attempts",          default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "confirmed_at"
  end

  add_index "users", ["checkout_icalendar_token"], name: "index_users_on_checkout_icalendar_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
