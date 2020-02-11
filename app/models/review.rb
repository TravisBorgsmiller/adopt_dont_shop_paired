class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content, :shelter_id
  belongs_to :shelter

  # attribute :image, :string, default: 'https://i.imgur.com/dciDr8Q.jpg'
end
