class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def average_rating
    if reviews.empty? == true
      'No ratings yet.'
    else
      ratings = reviews.map do |review|
        review.rating.to_i
      end
      ratings.sum / ratings.size
    end
  end

  def applications_count
    pets.joins(:pet_applications).count
  end
end
