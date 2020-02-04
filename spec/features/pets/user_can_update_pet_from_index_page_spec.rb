require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I click Edit Pet on the pets index page' do
    it 'it loads the edit form for that pet' do
      shelter3 = Shelter.create(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      pet1 = shelter3.pets.create!(image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
                                   name: 'Xylia',
                                   age: '5',
                                   sex: 'female',
                                   description: 'cool cool',
                                   status: 'adoptable')

      visit '/pets'

      within "p#pet_#{pet1.id}" do
        click_link 'Edit Pet'
      end

      expect(current_path).to eq("/pets/#{pet1.id}/edit")
    end
  end
end
