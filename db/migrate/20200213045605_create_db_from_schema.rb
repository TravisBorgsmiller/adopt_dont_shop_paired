class CreateDbFromSchema < ActiveRecord::Migration[5.1]
  def change

    create_table "applications", force: :cascade do |t|
      t.string "name"
      t.string "address"
      t.string "city"
      t.string "state"
      t.string "zip"
      t.string "phone"
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "pet_applications", force: :cascade do |t|
      t.bigint "pet_id"
      t.bigint "application_id"
      t.index ["application_id"], name: "index_pet_applications_on_application_id"
      t.index ["pet_id"], name: "index_pet_applications_on_pet_id"
    end

    create_table "pets", force: :cascade do |t|
      t.string "name"
      t.string "image", default: "https://i.imgur.com/HpDSNna.jpg"
      t.string "age"
      t.string "sex"
      t.string "description"
      t.string "status", default: "adoptable"
      t.bigint "shelter_id"
      t.string "pending_for", default: "none"
      t.index ["shelter_id"], name: "index_pets_on_shelter_id"
    end

    create_table "reviews", force: :cascade do |t|
      t.string "title"
      t.string "rating"
      t.text "content"
      t.string "image", default: "https://i.imgur.com/dciDr8Q.jpg"
      t.bigint "shelter_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["shelter_id"], name: "index_reviews_on_shelter_id"
    end

    create_table "shelters", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "address"
      t.string "city"
      t.string "state"
      t.string "zip"
    end
  end
end
