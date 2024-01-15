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

ActiveRecord::Schema.define(version: 2024_01_15_015015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_applications", force: :cascade do |t|
    t.string "applicant_name"
    t.string "applicant_address"
    t.string "applicant_phone"
    t.string "applicant_email"
    t.text "reason_for_adoption"
    t.bigint "pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_adoption_applications_on_pet_id"
  end

  create_table "pet_vaccinations", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "vaccination_id"
    t.date "vaccination_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_pet_vaccinations_on_pet_id"
    t.index ["vaccination_id"], name: "index_pet_vaccinations_on_vaccination_id"
  end

  create_table "pet_views", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_pet_views_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "breed"
    t.string "color"
    t.decimal "weight"
    t.integer "pet_type"
    t.integer "gender"
    t.integer "size"
    t.string "microchip_number"
    t.boolean "neutered", default: false
    t.boolean "house_trained", default: false
    t.boolean "special_needs", default: false
    t.boolean "suitable_for_apartments", default: false
    t.boolean "good_with_kids", default: false
    t.boolean "good_with_other_pets", default: false
    t.string "activity_level"
    t.text "personality_traits"
    t.text "medical_conditions"
    t.text "allergies"
    t.text "description"
    t.text "biography"
    t.date "date_of_birth"
    t.date "arrival_date"
    t.date "adoption_date"
    t.bigint "shelter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vaccinations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "adoption_applications", "pets"
  add_foreign_key "pet_vaccinations", "pets"
  add_foreign_key "pet_vaccinations", "vaccinations"
  add_foreign_key "pet_views", "pets"
  add_foreign_key "pets", "shelters"
end
