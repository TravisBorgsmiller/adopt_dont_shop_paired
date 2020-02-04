class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content, :image, :shelter_id
  belongs_to :shelter
end
