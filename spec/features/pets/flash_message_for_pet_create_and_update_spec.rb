require 'rails_helper'

RSpec.describe 'As a visitor when I create or update a pet with incomplete info' do
  it 'displays flash message with fields that are incomplete' do
    shelter3 = Shelter.create!(
      name: 'Zeus\'s Puppy Pals',
      address: '3734 Cedar Court',
      city: 'Boulder',
      state: 'CO',
      zip: '80301')
    buster = shelter3.pets.create!(
      image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
      name: 'Buster',
      description: 'Friendly',
      age: 3,
      sex: 'male')

    visit "/shelters/#{shelter3.id}/pets"

    click_link 'Create Pet'

    expect(current_path).to eq("/shelters/#{shelter3.id}/pets/new")

    fill_in :image, with: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg'
    fill_in :name, with: 'Zeus'
    fill_in :description, with: 'wild'
    fill_in :age, with: ''
    fill_in :sex, with: 'male'
    click_button 'Create Pet'
    expect(page).to have_content("Age can't be blank")
    expect(page).to have_button('Create Pet')

    visit "/pets/#{buster.id}"
    click_link 'Update Pet'
    fill_in :sex, with: ''
    fill_in :description, with: ''
    click_button 'Update Pet'
    expect(page).to have_content("Sex can't be blank and Description can't be blank")
    expect(page).to have_button('Update Pet')
  end
end
