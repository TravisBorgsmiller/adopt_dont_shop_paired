require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a shelter show page' do
    it 'I can click Delete Shelter' do
      shelter3 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      visit "/shelters/#{shelter3.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq('/shelters')

      expect(page).not_to have_content("Zeus's Puppy Pals")
      expect(page).not_to have_content("3734 Cedar Court")
    end
  end
end
