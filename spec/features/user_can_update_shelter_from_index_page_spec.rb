require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit shelters index and click on Update Shelter' do
    it 'it loads a form to update the shelter' do
      shelter3 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      shelter1 = Shelter.create(name: 'Xylia\'s Doggo Friends',
                                address: '3734 Ponderosa Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      pet1 = shelter3.pets.create!(image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
                                   name: 'Xylia',
                                   age: '5',
                                   sex: 'female',
                                   description: 'cool cool',
                                   status: 'adoptable')

      visit '/shelters'

      within "p#shelter_#{shelter3.id}" do
        click_link 'Edit Shelter'
      end

      expect(current_path).to eq("/shelters/#{shelter3.id}/edit")

      visit '/shelters'

      within "p#shelter_#{shelter1.id}" do
        click_link 'Edit Shelter'
      end

      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
    end
  end
end
