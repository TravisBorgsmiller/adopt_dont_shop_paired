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

    visit "/pets/#{@pet1.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet2.id}"
    click_button 'Favorite'

    visit '/favorites'
    click_link 'Adopt Pet(s)'

    expect(current_path).to eq('/applications/new')

    within("div#pet_#{@pet1.id}") do
      check :adopt_pets_
    end

    within("div#pet_#{@pet2.id}") do
      check :adopt_pets_
    end

    fill_in 'Name', with: 'Jordan Williams'
    fill_in 'Address', with: '4231 Ponderosa Court'
    fill_in 'City', with: 'Boulder'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80301'
    fill_in 'Phone', with: '323.940.3227'
    fill_in 'Description', with: "I'm a puppy parent"
    click_button 'Submit'

    expect(current_path).to eq('/favorites')

    @applications = Application.all
    @jordan_app = Application.find_by(name: 'Jordan Williams')
  end

  describe 'When I visit a pets show page and click a link for all applications' do
    it 'it will display a list of all applicant names for this pet' do
      visit "/pets/#{@pet1.id}"

      expect(current_path).to eq("/pets/#{@pet1.id}")

      click_link 'Applications'
      expect(current_path).to eq("/pets/#{@pet1.id}/applications")

      click_link 'Jordan Williams'
      expect(current_path).to eq("/applications/#{@jordan_app.id}")

      expect(page).to have_content(@jordan_app.name.to_s)
      expect(page).to have_content(@jordan_app.address.to_s)
      expect(page).to have_content(@jordan_app.city.to_s)
      expect(page).to have_content(@jordan_app.state.to_s)
      expect(page).to have_content(@jordan_app.zip.to_s)
      expect(page).to have_content(@jordan_app.phone.to_s)
      expect(page).to have_content(@jordan_app.description.to_s)
    end
  end
end
