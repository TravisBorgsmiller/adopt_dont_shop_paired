require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "When I click 'Create Pet'" do
    it 'it adds a pet to the current shelter' do
      shelter3 = Shelter.create!(
        name: 'Zeus\'s Puppy Pals',
        address: '3734 Cedar Court',
        city: 'Boulder',
        state: 'CO',
        zip: '80301')

      visit "/shelters/#{shelter3.id}/pets"

      click_link 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter3.id}/pets/new")

      fill_in 'Image', with: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg'
      fill_in 'Name', with: 'Zeus'
      fill_in 'Description', with: 'wild'
      fill_in 'Age', with: '3'
      fill_in 'Sex', with: 'male'

      click_button 'Create Pet'

      new_pet = Pet.last

      expect(current_path).to eq("/shelters/#{shelter3.id}/pets")

      expect(page).to have_css("img[src*='#{new_pet.image}']")
      expect(page).to have_content(new_pet.name)
      expect(page).to have_content(new_pet.description)
      expect(page).to have_content(new_pet.age)
      expect(page).to have_content(new_pet.sex)
      expect(page).to have_content(new_pet.status)
    end
  end
end
