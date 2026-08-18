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

ActiveRecord::Schema[8.1].define(version: 2026_08_18_133248) do
  create_table "czasopismos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "numer_wydania"
    t.date "przeczytano_w"
    t.integer "strony"
    t.string "tytul"
    t.datetime "updated_at", null: false
  end

  create_table "gatuneks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nazwa"
    t.datetime "updated_at", null: false
  end

  create_table "ksiazka_gatuneks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "gatunek_id", null: false
    t.integer "ksiazka_id", null: false
    t.datetime "updated_at", null: false
    t.index ["gatunek_id"], name: "index_ksiazka_gatuneks_on_gatunek_id"
    t.index ["ksiazka_id"], name: "index_ksiazka_gatuneks_on_ksiazka_id"
  end

  create_table "ksiazkas", force: :cascade do |t|
    t.string "autor"
    t.datetime "created_at", null: false
    t.string "format_ksiazki"
    t.boolean "jednotomowka"
    t.string "nazwa_serii"
    t.string "ocena"
    t.date "przeczytano_w"
    t.integer "strony"
    t.string "tytul"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ksiazka_gatuneks", "gatuneks"
  add_foreign_key "ksiazka_gatuneks", "ksiazkas"
end
