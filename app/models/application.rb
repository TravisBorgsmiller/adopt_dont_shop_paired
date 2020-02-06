class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_fav_pets(favorites)
    keys = favorites.keys
    @favorite_pets = []
    keys.each do |key|
      @favorite_pets << Pet.find(key)
    end
    @favorite_pets
  end
end
