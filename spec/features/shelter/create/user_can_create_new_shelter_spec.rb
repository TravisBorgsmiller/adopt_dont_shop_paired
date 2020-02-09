require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "When I visit the shelter index page and click 'New Shelter'" do
    it 'it takes me to a form to add a new shelter' do
      visit '/shelters'
      click_link('Add Shelter')

      visit '/shelters/new'

      fill_in(:name, with: "Xylia's Doggo Friends")
      fill_in(:address, with: '5723 Redwood Court')
      fill_in(:city, with: 'Boulder')
      fill_in(:state, with: 'CO')
      fill_in(:zip, with: 'Zip')

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
