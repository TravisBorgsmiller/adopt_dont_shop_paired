class AddPetsImageDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pets, :image, :string, default: 'https://i.imgur.com/HpDSNna.jpg'
    change_column_default :reviews, :image, :string, default: 'https://i.imgur.com/dciDr8Q.jpg'
  end
end
