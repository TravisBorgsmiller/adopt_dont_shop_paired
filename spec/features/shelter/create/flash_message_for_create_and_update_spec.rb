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
  end

  describe 'and it is successful' do
    it 'it displays a success flash message' do
      click_button('Create Shelter')

      expect(page).to have_content("City can't be blank")
      expect(current_path).to eq('/shelters')
    end
  end

  describe 'and it is not successful' do
    it 'it displays an error flash message' do
      fill_in(:city, with: 'Boulder')
      click_button('Create Shelter')

      expect(page).to have_content('Shelter successfully created')
      expect(current_path).to eq('/shelters')
    end
  end
end
