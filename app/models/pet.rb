class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age, :sex, :shelter_id, :status, :description
  belongs_to :shelter
  attribute :status, :string, default: "adoptable"
end
