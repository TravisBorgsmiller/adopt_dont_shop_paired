require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "When I visit the shelter index page and click 'New Shelter'" do
    it 'it takes me to a form to add a new shelter' do
      visit '/shelters'

      click_link('New Shelter')

      visit '/shelters/new'

      fill_in('Name', with: "Xylia's Doggo Friends")
      fill_in('Address', with: '5723 Redwood Court')
      fill_in('City', with: 'Boulder')
      fill_in('State', with: 'CO')
      fill_in('Zip', with: 'Zip')

      click_button('Create Shelter')

      expect(current_path).to eq('/shelters')

      new_shelter = Shelter.last

      expect(page).to have_content(new_shelter.name)
      expect(page).to have_content(new_shelter.address)
      expect(page).to have_content(new_shelter.city)
      expect(page).to have_content(new_shelter.state)
      expect(page).to have_content(new_shelter.zip)
    end
  end
end
