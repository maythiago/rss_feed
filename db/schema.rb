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

ActiveRecord::Schema[7.2].define(version: 2024_11_07_004341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.string "identifier", limit: 255
    t.integer "lock_version"
    t.bigint "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pub_date"
    t.index ["source_id"], name: "index_contents_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "summaries", force: :cascade do |t|
    t.text "summary"
    t.text "principal_facts", default: [], array: true
    t.text "conclusion"
    t.text "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "external_id"
  end

  add_foreign_key "contents", "sources"
end
