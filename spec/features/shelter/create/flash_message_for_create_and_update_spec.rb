require 'rails_helper'

RSpec.describe 'When I create or update a shelter', type: :feature do
  before :each do
    visit '/shelters'
    click_link('Add Shelter')

    expect(current_path).to eq('/shelters/new')

    fill_in(:name, with: "Xylia's Doggo Friends")
    fill_in(:address, with: '5723 Redwood Court')
    fill_in(:city, with: '')
    fill_in(:state, with: 'CO')
    fill_in(:zip, with: 'Zip')

    @shelter1 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                              address: '3734 Cedar Court',
                              city: 'Boulder',
                              state: 'CO',
                              zip: '80301')
  end

  describe 'and create is not successful' do
    it 'it displays a success flash message' do
      click_button('Create Shelter')

      expect(page).to have_content("City can't be blank")
      expect(current_path).to eq('/shelters')
    end
  end

  describe 'and create is successful' do
    it 'it displays an error flash message' do
      fill_in(:city, with: 'Boulder')
      click_button('Create Shelter')

      expect(page).to have_content('Shelter successfully created')
      expect(current_path).to eq('/shelters')
    end
  end

  describe 'and update is not successful' do
    it 'it displays an error flash message' do
      visit "/shelters/#{@shelter1.id}/edit"
      fill_in(:city, with: '')
      click_button('Update Shelter')

      expect(page).to have_content("City can't be blank")
      expect(current_path).to eq("/shelters/#{@shelter1.id}")
    end
  end

  describe 'and update is successful' do
    it 'it displays an error flash message' do
      visit "/shelters/#{@shelter1.id}/edit"
      fill_in(:city, with: 'Boulder')
      click_button('Update Shelter')

      expect(page).to have_content('Shelter successfully updated')
      expect(current_path).to eq("/shelters/#{@shelter1.id}")
    end
  end
end
