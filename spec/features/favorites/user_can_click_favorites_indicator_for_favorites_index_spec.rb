require 'rails_helper'

RSpec.describe 'When clicking favorites indicator in nav' do
  it 'takes me to favorites index page' do
    shelter1 = Shelter.create(
      name: "Mike's Shelter",
      address: '1331 17th Street',
      city: 'Denver',
      state: 'CO',
      zip: '80202'
    )

    pet1 = shelter1.pets.create(
      image: 'https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg',
      name: 'Athena',
      description: 'butthead',
      age: '1',
      sex: 'female',
      status: 'adoptable'
    )

    review1 = shelter1.reviews.create(
      title: "A glowing review",
      rating: "5",
      content: "Great facility, friendly staff!",
      image: "https://i.imgur.com/dciDr8Q.jpg"
    )

    visit "/pets/#{pet1.id}"
    click_button 'Favorite'
    click_link 'Favorites: 1'
    expect(current_path).to eq('/favorites')
  end
end
