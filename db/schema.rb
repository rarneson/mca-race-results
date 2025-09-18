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

ActiveRecord::Schema[8.0].define(version: 2025_09_17_005326) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sort_order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "race_result_laps", force: :cascade do |t|
    t.integer "race_result_id", null: false
    t.integer "lap_number"
    t.integer "lap_time_ms"
    t.integer "cumulative_time_ms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lap_time_raw"
    t.string "cumulative_time_raw"
    t.index ["race_result_id"], name: "index_race_result_laps_on_race_result_id"
  end

  create_table "race_results", force: :cascade do |t|
    t.integer "race_id", null: false
    t.integer "racer_season_id", null: false
    t.integer "place"
    t.integer "total_time_ms"
    t.integer "laps_completed"
    t.integer "laps_expected"
    t.string "status"
    t.string "plate_number_snapshot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "total_time_raw"
    t.integer "category_id"
    t.text "comments"
    t.index ["category_id"], name: "index_race_results_on_category_id"
    t.index ["race_id", "racer_season_id"], name: "index_race_results_on_race_id_and_racer_season_id", unique: true
    t.index ["race_id"], name: "index_race_results_on_race_id"
    t.index ["racer_season_id"], name: "index_race_results_on_racer_season_id"
  end

  create_table "racer_seasons", force: :cascade do |t|
    t.integer "racer_id", null: false
    t.integer "year"
    t.string "plate_number"
    t.integer "penalty_ms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["racer_id"], name: "index_racer_seasons_on_racer_id"
  end

  create_table "racers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "number"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_racers_on_team_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.date "race_date"
    t.string "location"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "race_result_laps", "race_results"
  add_foreign_key "race_results", "categories"
  add_foreign_key "race_results", "racer_seasons"
  add_foreign_key "race_results", "races"
  add_foreign_key "racer_seasons", "racers"
  add_foreign_key "racers", "teams"
end
