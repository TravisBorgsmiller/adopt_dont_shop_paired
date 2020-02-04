require 'rails_helper'

RSpec.describe 'As a vistor', type: :feature do
  describe "When I visit a shelter show page and click 'Update Shelter'" do
    it 'it loads a form to update the current shelter data' do
      shelter3 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      visit "/shelters/#{shelter3.id}"

      click_link 'Update Shelter'

      visit "/shelters/#{shelter3.id}/edit"
      fill_in 'Name', with: shelter3.name
      fill_in 'Address', with: shelter3.address
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: shelter3.state
      fill_in 'Zip', with: shelter3.zip

      click_button 'Save'

      expect(current_path).to eq("/shelters/#{shelter3.id}")

      expect(page).to have_content(shelter3.name)
      expect(page).to have_content(shelter3.address)
      expect(page).to have_content('City: Denver')
      expect(page).to have_content(shelter3.state)
      expect(page).to have_content(shelter3.zip)
      expect(page).not_to have_content("Xylia's Doggo Friends")
    end
  end
end

# User Story 5, Shelter Update

# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
