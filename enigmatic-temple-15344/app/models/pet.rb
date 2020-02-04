class Pet < ApplicationRecord
  validates_presence_of :name, :image, :age, :sex, :shelter_id
  belongs_to :shelter
end
