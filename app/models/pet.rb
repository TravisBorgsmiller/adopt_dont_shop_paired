class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age, :sex, :shelter_id, :status, :description
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  attribute :status, :string, default: 'adoptable'
end
