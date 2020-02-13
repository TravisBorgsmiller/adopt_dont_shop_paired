class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content, :shelter_id, :image
  belongs_to :shelter
  validates :image, format: URI::regexp(%w[http https])
end
