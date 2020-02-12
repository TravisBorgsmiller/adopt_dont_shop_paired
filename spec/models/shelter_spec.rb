require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end
  describe 'relationships' do
    it {should have_many (:pets)}
  end
  describe 'methods' do
    before :each do
    @shelter1 = Shelter.create(
      name: "Mike's Shelter",
      address: '1331 17th Street',
      city: 'Denver',
      state: 'CO',
      zip: '80202'
    )

    @pet1 = @shelter1.pets.create(
      image: 'https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg',
      name: 'Athena',
      description: 'butthead',
      age: '1',
      sex: 'female',
      status: 'adoptable'
    )

    @pet2 = @shelter1.pets.create(
      image: 'https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg',
      name: 'Odell',
      description: 'good dog',
      age: '4',
      sex: 'male',
      status: 'adoptable'
    )
    @review1 = @shelter1.reviews.create(
      title: 'A glowing review',
      rating: '5',
      content: 'Great facility, friendly staff!',
      image: 'https://i.imgur.com/dciDr8Q.jpg'
    )
    @review2 = @shelter1.reviews.create(
      title: 'Not a glowing review',
      rating: '2',
      content: 'Great facility, mean staff!',
      image: 'https://i.imgur.com/dciDr8Q.jpg'
    )
    @app = Application.create(
      name: 'Joe',
      address: '302 woo hoo st',
      city: 'Nowhere',
      state: 'MO',
      zip: '63386',
      phone: '636-981-0204',
      description: 'Happy go lucky guy'
    )
    @app.pets << [@pet1, @pet2]
    end
    it 'can count number of pets' do
      expect(@shelter1.pet_count).to eq(2)
    end
    it 'gives average review rating' do
      expect(@shelter1.average_rating).to eq(3)
    end
    it 'gives count of applications for pets at shelter' do
      expect(@shelter1.applications_count).to eq(2)
    end
  end
end
