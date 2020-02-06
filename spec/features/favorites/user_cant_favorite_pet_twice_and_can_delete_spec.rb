require 'rails_helper'

RSpec.describe 'As a visitor when I favorite a pet' do
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
  it 'will only favorite the pet once' do
    visit "/pets/#{@pet1.id}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    click_button 'Favorite'
    expect(page).to have_content("Favorites: 1")
    expect(page).not_to have_button('Favorite')
  end
  it 'will delete favorite' do
    visit "/pets/#{@pet1.id}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    click_button 'Favorite'
    expect(page).to have_content("Favorites: 1")
    click_button 'Delete from favorites'
    expect(current_path).to eq('/favorites')
    within '.favoritePets' do
      expect(page).not_to have_content(@pet1.image)
      expect(page).not_to have_content(@pet1.name)
      expect(page).not_to have_content(@pet1.description)
    end
    expect(page).to have_content("#{@pet1.name} has been removed from Favorites!")
  end
end
