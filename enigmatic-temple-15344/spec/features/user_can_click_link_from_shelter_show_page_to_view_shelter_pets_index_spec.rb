require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a shelter show page' do
    it 'I can click a link to view the shelter pets index' do
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

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_link("Available Pets")
      click_link "Available Pets"
      expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
    end
  end
end
