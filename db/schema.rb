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

ActiveRecord::Schema[7.0].define(version: 2023_01_07_150418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forces", force: :cascade do |t|
    t.string "api_id"
    t.string "name"
    t.text "description"
    t.string "telephone"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "twitter_url"
    t.string "facebook_url"
    t.string "youtube_url"
  end

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "api_id"
    t.string "name"
    t.string "url"
    t.float "lat"
    t.float "long"
    t.text "description"
    t.bigint "force_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["force_id"], name: "index_neighbourhoods_on_force_id"
  end

  add_foreign_key "neighbourhoods", "forces"
end
