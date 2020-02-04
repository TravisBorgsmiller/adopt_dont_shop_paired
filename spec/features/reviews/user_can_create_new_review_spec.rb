require 'rails_helper'

RSpec.describe 'As a visitor I can create a new shelter review' do
  it 'links form from shelter show page' do
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

    visit "/shelters/#{shelter1.id}"
    expect(current_path).to eq("/shelters/#{shelter1.id}")

    click_link "Create new review for #{shelter1.name}"
    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")

    fill_in :title, with: 'Bomb Review'
    select '5', from: :rating
    fill_in :content, with: 'Fabulous facilities'
    fill_in :image, with: ''
    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to have_content('Bomb Review')
    expect(page).to have_content('Fabulous facilities')
  end
end
