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

ActiveRecord::Schema.define(version: 1) do

  create_table "core_person", primary_key: "person_id", force: :cascade do |t|
    t.integer  "person_type_id", limit: 4, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "core_person", ["person_id"], name: "person_id_UNIQUE", unique: true, using: :btree
  add_index "core_person", ["person_type_id"], name: "fk_core_person_1_idx", using: :btree

  create_table "guardianship", primary_key: "guardianship_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  create_table "level_of_education", primary_key: "level_of_education_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  create_table "location", primary_key: "location_id", force: :cascade do |t|
    t.string   "code",            limit: 45
    t.string   "name",            limit: 255, default: "",    null: false
    t.string   "description",     limit: 255
    t.string   "postal_code",     limit: 50
    t.string   "country",         limit: 50
    t.string   "latitude",        limit: 50
    t.string   "longitude",       limit: 50
    t.integer  "creator",         limit: 4,   default: 0,     null: false
    t.datetime "date_created",                                null: false
    t.string   "county_district", limit: 255
    t.boolean  "voided",                      default: false, null: false
    t.integer  "voided_by",       limit: 4
    t.datetime "date_voided"
    t.string   "void_reason",     limit: 255
    t.integer  "parent_location", limit: 4
    t.string   "uuid",            limit: 38,                  null: false
    t.integer  "changed_by",      limit: 4
    t.datetime "date_changed"
  end

  add_index "location", ["changed_by"], name: "location_changed_by", using: :btree
  add_index "location", ["creator"], name: "user_who_created_location", using: :btree
  add_index "location", ["name"], name: "name_of_location", using: :btree
  add_index "location", ["parent_location"], name: "parent_location", using: :btree
  add_index "location", ["uuid"], name: "location_uuid_index", unique: true, using: :btree
  add_index "location", ["voided"], name: "retired_status", using: :btree
  add_index "location", ["voided_by"], name: "user_who_retired_location", using: :btree

  create_table "location_tag", primary_key: "location_tag_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.integer  "voided_by",   limit: 4
    t.string   "void_reason", limit: 45
    t.datetime "date_voided"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "location_tag", ["location_tag_id"], name: "location_tag_map_id_UNIQUE", unique: true, using: :btree

  create_table "location_tag_map", id: false, force: :cascade do |t|
    t.integer "location_id",     limit: 4, null: false
    t.integer "location_tag_id", limit: 4, null: false
  end

  add_index "location_tag_map", ["location_id"], name: "fk_location_tag_map_1", using: :btree
  add_index "location_tag_map", ["location_tag_id"], name: "fk_location_tag_map_2_idx", using: :btree

  create_table "mode_of_delivery", primary_key: "mode_of_delivery_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  create_table "person", primary_key: "person_id", force: :cascade do |t|
    t.string   "gender",              limit: 6,             null: false
    t.integer  "birthdate_estimated", limit: 1, default: 0, null: false
    t.date     "birthdate",                                 null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "person_addresses", primary_key: "person_addresses_id", force: :cascade do |t|
    t.integer  "person_id",              limit: 4,   null: false
    t.integer  "current_village",        limit: 4
    t.string   "current_village_other",  limit: 255
    t.integer  "current_ta",             limit: 4
    t.string   "current_ta_other",       limit: 255
    t.integer  "current_district",       limit: 4
    t.string   "current_district_other", limit: 255
    t.integer  "home_village",           limit: 4
    t.string   "home_village_other",     limit: 255
    t.integer  "home_ta",                limit: 4
    t.string   "home_ta_other",          limit: 255
    t.integer  "home_district",          limit: 4
    t.string   "home_district_other",    limit: 255
    t.integer  "citizenship",            limit: 4,   null: false
    t.integer  "residential_country",    limit: 4,   null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "person_addresses", ["citizenship"], name: "fk_person_addresses_8_idx", using: :btree
  add_index "person_addresses", ["current_district"], name: "fk_person_addresses_4_idx", using: :btree
  add_index "person_addresses", ["current_ta"], name: "fk_person_addresses_3_idx", using: :btree
  add_index "person_addresses", ["current_village", "current_ta", "current_district", "home_village", "home_ta", "home_district"], name: "fk_person_addresses_2_idx", using: :btree
  add_index "person_addresses", ["home_district"], name: "fk_person_addresses_7_idx", using: :btree
  add_index "person_addresses", ["home_ta"], name: "fk_person_addresses_6_idx", using: :btree
  add_index "person_addresses", ["home_village"], name: "fk_person_addresses_5_idx", using: :btree
  add_index "person_addresses", ["person_id"], name: "fk_person_addresses_1_idx", using: :btree

  create_table "person_attribute_types", primary_key: "person_attribute_type_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
    t.datetime "created_at",                          null: false
    t.datetime "update_at",                           null: false
  end

  create_table "person_attributes", primary_key: "person_attribute_id", force: :cascade do |t|
    t.integer  "person_id",                limit: 4,               null: false
    t.integer  "person_attribute_type_id", limit: 4,               null: false
    t.integer  "voided",                   limit: 1,   default: 0, null: false
    t.string   "value",                    limit: 100,             null: false
    t.integer  "voided_by",                limit: 4
    t.datetime "date_voided"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "person_attributes", ["person_attribute_type_id"], name: "fk_person_attributes_2_idx", using: :btree
  add_index "person_attributes", ["person_id"], name: "fk_person_attributes_1_idx", using: :btree

  create_table "person_birth_details", primary_key: "person_birth_details_id", force: :cascade do |t|
    t.integer "person_id",                               limit: 4,              null: false
    t.integer "place_of_birth",                          limit: 4,              null: false
    t.integer "birth_location_id",                       limit: 4,              null: false
    t.string  "other_birth_location",                    limit: 45
    t.float   "birth_weight",                            limit: 24
    t.integer "type_of_birth",                           limit: 4,              null: false
    t.integer "parents_married_to_each_other",           limit: 1,  default: 0, null: false
    t.date    "date_of_marriage"
    t.integer "gestation_at_birth",                      limit: 4
    t.integer "number_of_prenatal_visits",               limit: 4
    t.integer "month_prenatal_care_started",             limit: 4
    t.integer "mode_of_delivery",                        limit: 4,              null: false
    t.integer "number_of_children_born_alive_inclusive", limit: 4,  default: 1, null: false
    t.integer "number_of_children_born_still_alive",     limit: 4,  default: 1, null: false
    t.integer "level_of_education",                      limit: 4,              null: false
    t.string  "district_id_number",                      limit: 20
    t.integer "national_serial_number",                  limit: 4
    t.integer "court_order_attached",                    limit: 1,  default: 0, null: false
    t.date    "acknowledgement_of_receipt_date",                                null: false
    t.string  "facility_serial_number",                  limit: 30
    t.integer "guardianship",                            limit: 4,              null: false
    t.integer "adoption_court_order",                    limit: 1,  default: 0, null: false
  end

  add_index "person_birth_details", ["birth_location_id"], name: "fk_person_birth_details_3_idx", using: :btree
  add_index "person_birth_details", ["district_id_number"], name: "district_id_number_UNIQUE", unique: true, using: :btree
  add_index "person_birth_details", ["facility_serial_number"], name: "facility_serial_number_UNIQUE", unique: true, using: :btree
  add_index "person_birth_details", ["guardianship"], name: "fk_person_birth_details_6_idx", using: :btree
  add_index "person_birth_details", ["level_of_education"], name: "fk_person_birth_details_7_idx", using: :btree
  add_index "person_birth_details", ["mode_of_delivery"], name: "fk_person_birth_details_5_idx", using: :btree
  add_index "person_birth_details", ["national_serial_number"], name: "national_serial_number_UNIQUE", unique: true, using: :btree
  add_index "person_birth_details", ["person_id"], name: "fk_person_birth_details_1_idx", using: :btree
  add_index "person_birth_details", ["place_of_birth"], name: "fk_person_birth_details_4_idx", using: :btree
  add_index "person_birth_details", ["type_of_birth"], name: "fk_person_birth_details_2_idx", using: :btree

  create_table "person_name", primary_key: "person_name_id", force: :cascade do |t|
    t.integer  "person_id",   limit: 4,               null: false
    t.string   "first_name",  limit: 45,              null: false
    t.string   "middle_name", limit: 45
    t.string   "last_name",   limit: 45,              null: false
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "person_name", ["person_id"], name: "fk_person_name_1_idx", using: :btree
  add_index "person_name", ["voided_by"], name: "fk_person_name_2_idx", using: :btree

  create_table "person_name_code", primary_key: "person_name_code_id", force: :cascade do |t|
    t.integer  "person_name_id",   limit: 4,  null: false
    t.string   "first_name_code",  limit: 10, null: false
    t.string   "middle_name_code", limit: 10
    t.string   "last_name_code",   limit: 10, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "person_name_code", ["person_name_id"], name: "fk_person_name_code_1_idx", using: :btree

  create_table "person_record_statuses", primary_key: "person_record_status_id", force: :cascade do |t|
    t.integer  "status_id",   limit: 4,   null: false
    t.integer  "person_id",   limit: 4,   null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "voided",      limit: 1
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  add_index "person_record_statuses", ["person_id"], name: "fk_person_record_statuses_1_idx", using: :btree
  add_index "person_record_statuses", ["status_id"], name: "fk_person_record_statuses_2_idx", using: :btree
  add_index "person_record_statuses", ["voided_by"], name: "fk_person_record_statuses_3_idx", using: :btree

  create_table "person_relationship", primary_key: "person_relationship_id", force: :cascade do |t|
    t.integer  "person_a",                    limit: 4, null: false
    t.integer  "person_b",                    limit: 4, null: false
    t.integer  "person_relationship_type_id", limit: 4, null: false
    t.datetime "created_at",                            null: false
    t.datetime "update_at",                             null: false
  end

  add_index "person_relationship", ["person_a"], name: "fk_person_relationship_1_idx", using: :btree
  add_index "person_relationship", ["person_b"], name: "fk_person_relationship_2_idx", using: :btree
  add_index "person_relationship", ["person_relationship_type_id"], name: "fk_person_relationship_3_idx", using: :btree

  create_table "person_relationship_types", primary_key: "person_relationship_type_id", force: :cascade do |t|
    t.string   "name",        limit: 25,             null: false
    t.integer  "voided",      limit: 1,  default: 0, null: false
    t.string   "description", limit: 45
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  create_table "person_type", primary_key: "person_type_id", force: :cascade do |t|
    t.string "name",        limit: 45, null: false
    t.string "description", limit: 45
  end

  create_table "person_type_of_births", primary_key: "person_type_of_birth_id", force: :cascade do |t|
    t.string   "name",        limit: 45,              null: false
    t.string   "description", limit: 100
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "voided",      limit: 1,   default: 0, null: false
    t.string   "void_reason", limit: 100
    t.integer  "voided_by",   limit: 4
    t.datetime "date_voided"
  end

  create_table "role", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4,  default: 0,  null: false
    t.string  "role",    limit: 50, default: "", null: false
    t.integer "level",   limit: 4
  end

  add_index "role", ["role_id"], name: "fk_user_role_1_idx", using: :btree

  create_table "statuses", primary_key: "status_id", force: :cascade do |t|
    t.string   "name",        limit: 45
    t.string   "description", limit: 100
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_role", primary_key: "user_role_id", force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.integer "role_id", limit: 4, null: false
  end

  add_index "user_role", ["role_id"], name: "fk_user_role_2_idx", using: :btree
  add_index "user_role", ["user_id"], name: "fk_user_role_1_idx", using: :btree

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.integer  "location_id",     limit: 4
    t.string   "username",        limit: 50
    t.string   "password",        limit: 128
    t.string   "salt",            limit: 128
    t.string   "secret_question", limit: 255
    t.string   "secret_answer",   limit: 255
    t.integer  "creator",         limit: 4,   default: 0, null: false
    t.datetime "created_at",                              null: false
    t.integer  "updated_by",      limit: 4
    t.datetime "updated_at"
    t.integer  "person_id",       limit: 4
    t.integer  "voided",          limit: 1,   default: 0, null: false
    t.integer  "voided_by",       limit: 4
    t.datetime "date_voided"
    t.string   "void_reason",     limit: 255
    t.string   "uuid",            limit: 38,              null: false
  end

  add_index "users", ["person_id"], name: "fk_users_1_idx", using: :btree
  add_index "users", ["voided_by"], name: "fk_users_2_idx", using: :btree

  add_foreign_key "core_person", "person_type", primary_key: "person_type_id", name: "fk_core_person_1"
  add_foreign_key "location_tag_map", "location", primary_key: "location_id", name: "fk_location_tag_map_1"
  add_foreign_key "location_tag_map", "location_tag", primary_key: "location_tag_id", name: "fk_location_tag_map_2"
  add_foreign_key "person", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_1"
  add_foreign_key "person_addresses", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_addresses_1"
  add_foreign_key "person_addresses", "location", column: "current_district", primary_key: "location_id", name: "fk_person_addresses_4"
  add_foreign_key "person_addresses", "location", column: "current_ta", primary_key: "location_id", name: "fk_person_addresses_3"
  add_foreign_key "person_addresses", "location", column: "current_village", primary_key: "location_id", name: "fk_person_addresses_2"
  add_foreign_key "person_addresses", "location", column: "home_district", primary_key: "location_id", name: "fk_person_addresses_7"
  add_foreign_key "person_addresses", "location", column: "home_ta", primary_key: "location_id", name: "fk_person_addresses_6"
  add_foreign_key "person_addresses", "location", column: "home_village", primary_key: "location_id", name: "fk_person_addresses_5"
  add_foreign_key "person_attributes", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_attributes_1"
  add_foreign_key "person_attributes", "person_attribute_types", primary_key: "person_attribute_type_id", name: "fk_person_attributes_2"
  add_foreign_key "person_birth_details", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_birth_details_1"
  add_foreign_key "person_birth_details", "guardianship", column: "guardianship", primary_key: "guardianship_id", name: "fk_person_birth_details_6"
  add_foreign_key "person_birth_details", "level_of_education", column: "level_of_education", primary_key: "level_of_education_id", name: "fk_person_birth_details_4"
  add_foreign_key "person_birth_details", "location", column: "birth_location_id", primary_key: "location_id", name: "fk_person_birth_details_3"
  add_foreign_key "person_birth_details", "location", column: "place_of_birth", primary_key: "location_id", name: "fk_person_birth_details_2"
  add_foreign_key "person_birth_details", "mode_of_delivery", column: "mode_of_delivery", primary_key: "mode_of_delivery_id", name: "fk_person_birth_details_5"
  add_foreign_key "person_birth_details", "person_type_of_births", column: "type_of_birth", primary_key: "person_type_of_birth_id", name: "fk_person_birth_details_7"
  add_foreign_key "person_name", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_name_1"
  add_foreign_key "person_name", "users", column: "voided_by", primary_key: "user_id", name: "fk_person_name_2"
  add_foreign_key "person_name_code", "person_name", primary_key: "person_name_id", name: "fk_person_name_code_1"
  add_foreign_key "person_record_statuses", "core_person", column: "person_id", primary_key: "person_id", name: "fk_person_record_statuses_1"
  add_foreign_key "person_record_statuses", "statuses", primary_key: "status_id", name: "fk_person_record_statuses_2"
  add_foreign_key "person_record_statuses", "users", column: "voided_by", primary_key: "user_id", name: "fk_person_record_statuses_3"
  add_foreign_key "person_relationship", "core_person", column: "person_a", primary_key: "person_id", name: "fk_person_relationship_1"
  add_foreign_key "person_relationship", "core_person", column: "person_b", primary_key: "person_id", name: "fk_person_relationship_2"
  add_foreign_key "person_relationship", "person_relationship_types", primary_key: "person_relationship_type_id", name: "fk_person_relationship_3"
  add_foreign_key "user_role", "role", primary_key: "role_id", name: "fk_user_role_2"
  add_foreign_key "user_role", "users", primary_key: "user_id", name: "fk_user_role_1"
  add_foreign_key "users", "core_person", column: "person_id", primary_key: "person_id", name: "fk_users_1"
  add_foreign_key "users", "users", column: "voided_by", primary_key: "user_id", name: "fk_users_2"
end
