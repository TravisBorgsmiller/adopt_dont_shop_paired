class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content, :shelter_id, :image
  belongs_to :shelter
  validates :image, format: URI::regexp(%w[http https])
  validates :image, format: { with: %r{.(gif|jpg|png)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }
end
