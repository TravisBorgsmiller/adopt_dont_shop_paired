require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit my favorites page' do
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
    end

    it 'I click on link to adopt pets' do
      visit '/favorites'

      click_link 'Adopt Pet(s)'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_css("#pet_#{@pet1.id}")
      expect(page).to have_button('Submit')
      expect(page).to have_field('Name')
      expect(page).to have_field('Address')
      expect(page).to have_field('City')
      expect(page).to have_field('State')
      expect(page).to have_field('Zip')
      expect(page).to have_field('Phone')
      expect(page).to have_field('Description')
      click_button('Submit')

      expect(page).to have_content('Application not submitted. Please complete the required fields.')
      expect(current_path).to eq('/applications/new')
    end

    it 'I complete and submit the adoption form' do
      visit '/favorites'
      click_link 'Adopt Pet(s)'

      expect(current_path).to eq('/applications/new')

      within("div#pet_#{@pet1.id}") do
        check :adopt_pets_
      end

      within("div#pet_#{@pet2.id}") do
        check :adopt_pets_
      end

      fill_in 'Name', with: 'Jordan'
      fill_in 'Address', with: '4231 Ponderosa Court'
      fill_in 'City', with: 'Boulder'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80301'
      fill_in 'Phone', with: '323.940.3227'
      fill_in 'Description', with: "I'm a puppy parent"
      click_button 'Submit'

      expect(page).to have_content('Application submitted, thank you!')
      expect(current_path).to eq('/favorites')

      within("div.favoritePetsBlock") do
        expect(page).to_not have_content('Athena')
        expect(page).to_not have_content('Odell')
      end
    end
  end
end
