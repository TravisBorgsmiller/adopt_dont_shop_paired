require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'there is a link to pets index' do
    it 'on every page' do
      shelter1 = Shelter.create(name: 'Xylia\'s Doggo Friends',
                                address: '3734 Ponderosa Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      pet1 = shelter1.pets.create!(image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
                                   name: 'Xylia',
                                   age: '5',
                                   sex: 'female',
                                   description: 'cool cool',
                                   status: 'adoptable')

      visit "/"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/pets"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/pets/#{pet1.id}"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/pets/#{pet1.id}/edit"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/shelters"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter1.id}/pets"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter1.id}/edit"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")

      visit "/shelters/new"
      expect(page).to have_link("Pets")
      click_link "Pets"
      expect(current_path).to eq("/pets")
    end
  end
end
