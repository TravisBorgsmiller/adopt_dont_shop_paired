require 'rails_helper'

describe "favorites", type: :feature do
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

    @review1 = @shelter1.reviews.create(
      title: "A glowing review",
      rating: "5",
      content: "Great facility, friendly staff!",
      image: "https://i.imgur.com/dciDr8Q.jpg"
    )
  end

  it 'shows count of all favorited pets on nav bar' do
    visit "/"
    expect(page).to have_content("Favorites: 0")
    visit "/shelters"
    expect(page).to have_content("Favorites: 0")
    visit "/pets/#{@pet1.id}"
    click_button('Favorite')
    expect(page).to have_content("Favorites: 1")
    expect(page).to have_content("#{@pet1.name} has been added to your favorites!")
  end

end
