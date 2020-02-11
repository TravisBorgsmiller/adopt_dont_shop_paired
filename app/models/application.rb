class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_fav_pets(favorites)
    Pet.find(favorites.keys)
  end

  def revoke_application(pet)
    PetApplication.find_by(application_id: id, pet_id: pet.id, pending: true)
  end
end
