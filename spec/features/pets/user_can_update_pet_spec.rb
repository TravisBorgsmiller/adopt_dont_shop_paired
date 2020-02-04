require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a pet show page and click Update Pet' do
    it 'it allows me to update the pet information' do
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

      click_link 'Update Pet'

      expect(current_path).to eq("/pets/#{pet1.id}/edit")

      fill_in 'Image', with: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg'
      fill_in 'Name', with: 'Xylia'
      fill_in 'Age', with: '6'
      fill_in 'Sex', with: 'female'
      fill_in 'Description', with: 'cool cool'
      fill_in 'Status', with: 'adopted'

      click_button 'Update Pet'

      expect(current_path).to eq("/pets/#{pet1.id}")

      expect(page).to have_css("img[src*='#{pet1.image}']")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content('Age: 6')
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet1.description)
      expect(page).to have_content('Status: adopted')
    end
  end
end
