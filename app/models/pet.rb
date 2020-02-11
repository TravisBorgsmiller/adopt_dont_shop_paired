class Pet < ApplicationRecord
  validates_presence_of :name,
                        :age,
                        :sex,
                        :shelter_id,
                        :status,
                        :description,
                        :image
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  attribute :status, :string, default: 'adoptable'
  attribute :image, :string, default: 'https://i.imgur.com/HpDSNna.jpg'

  def pending_for
    pet_app = PetApplication.find_by(pet_id: id, pending: true)
    pet_app.application.name
  end
end
