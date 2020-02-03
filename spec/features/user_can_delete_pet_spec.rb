require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a pet show page' do
    it 'I can click delete pet to remove pet' do
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

      visit "/pets/#{pet1.id}"

      click_link 'Delete Pet'

      expect(current_path).to eq('/pets')

      expect(page).to have_no_content(pet1.name)
    end
  end
end
