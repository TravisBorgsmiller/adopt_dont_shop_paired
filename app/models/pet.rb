class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age, :sex, :shelter_id, :status, :description
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  attribute :status, :string, default: 'adoptable'

  def pending_for
    pet_app = pet_applications
    Application.find(pet_app.first[:application_id]).name
  end
end
