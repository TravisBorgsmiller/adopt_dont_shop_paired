require 'rails_helper'

RSpec.describe 'As a visitor I can create a new shelter review' do
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
  end
  it 'links form from shelter show page' do

    visit "/shelters/#{@shelter1.id}"
    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    click_link "Create new review for #{@shelter1.name}"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
    fill_in :title, with: 'Bomb Review'
    select '5', from: :rating
    fill_in :content, with: 'Fabulous facilities'
    click_button 'Submit'
    expect(page).to have_content('Review Created!')
    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content('Bomb Review')
    expect(page).to have_content('Fabulous facilities')
  end

  it "does not allow a user to create a review without required information" do

    visit "/shelters/#{@shelter1.id}"
    click_link "Create new review for #{@shelter1.name}"

    fill_in :title, with: 'This place is remarkable!'
    fill_in :content, with: 'Friendly attendants.'

    click_button('Submit')

    expect(page).to have_content("Rating can't be blank")
    expect(page).to have_button('Submit')
  end
end
