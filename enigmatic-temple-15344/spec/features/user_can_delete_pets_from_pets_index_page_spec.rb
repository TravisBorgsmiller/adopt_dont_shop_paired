require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I click Delete a pet from pets or shelters index page' do
    it 'it will delete the pet' do
      shelter2 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      shelter1 = Shelter.create(name: 'Xylia\'s Doggo Friends',
                                address: '1241 Ponderosa Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      pet1 = shelter2.pets.create!(image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
                                   name: 'Xylia',
                                   age: '5',
                                   sex: 'female',
                                   description: 'cool cool',
                                   status: 'adoptable')

      pet2 = shelter1.pets.create!(image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
                                   name: 'Zeus',
                                   age: '3',
                                   sex: 'male',
                                   description: 'wild',
                                   status: 'adoptable')

      visit '/pets'

      within "p#delete_#{pet1.id}" do
        click_link 'Delete'
      end

      expect(current_path).to eq('/pets')
      expect(page).to have_no_content('Name: Xylia')

      visit "/shelters/#{shelter1.id}/pets"

      within "p#delete_#{pet2.id}" do
        click_link 'Delete'
      end

      expect(page).to have_no_content('Name: Zeus')
    end
  end
end
