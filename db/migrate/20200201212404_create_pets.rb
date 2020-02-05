class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string "name"
      t.string "image"
      t.string "age"
      t.string "sex"
      t.string "description"
      t.string "status", default: 'adoptable'
      t.references :shelter, foreign_key: true
    end
  end
end
