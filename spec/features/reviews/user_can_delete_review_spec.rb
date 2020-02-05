require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
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

  it 'I can delete a review from the shelter show page' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content('A glowing review')
    expect(page).to have_content('Great facility, friendly staff!')
    click_link 'Delete Review'

    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    expect(page).to_not have_content('A glowing review')
    expect(page).to_not have_content('Rating: 5')
    expect(page).to_not have_content('Great facility, friendly staff!')
    expect(page).to_not have_css("img[src*='#{@review1.image}']")
  end
end
