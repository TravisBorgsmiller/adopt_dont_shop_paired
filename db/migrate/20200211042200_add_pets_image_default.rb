class AddPetsImageDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :pets, :image, :string, default: 'https://i.imgur.com/HpDSNna.jpg'
  end
end
