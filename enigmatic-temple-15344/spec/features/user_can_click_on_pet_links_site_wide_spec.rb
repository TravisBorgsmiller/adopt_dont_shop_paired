require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I see a pet name anywhere on the site' do
    it 'I can click it to access the pet show page' do
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

      visit "/shelters/#{shelter1.id}/pets"
      expect(page).to have_link("#{pet1.name}")
      click_link "#{pet1.name}"
      expect(current_path).to eq("/pets/#{pet1.id}")

      visit "/pets/#{pet1.id}/edit"
      expect(page).to have_link("#{pet1.name}")
      click_link "#{pet1.name}"
      expect(current_path).to eq("/pets/#{pet1.id}")

      visit "/pets"
      expect(page).to have_link("#{pet1.name}")
      click_link "#{pet1.name}"
      expect(current_path).to eq("/pets/#{pet1.id}")
    end
  end
end
