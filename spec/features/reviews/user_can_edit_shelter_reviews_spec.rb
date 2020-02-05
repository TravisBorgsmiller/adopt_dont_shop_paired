require 'rails_helper'

RSpec.describe 'As a visitor I can edit a shelter review from its show page', type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "Mike's Shelter",
      address: '1331 17th Street',
      city: 'Denver',
      state: 'CO',
      zip: '80202'
    )

    @pet1 = @shelter1.pets.create(
      image: 'https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg',
      name: 'Athena',
      description: 'butthead',
      age: '1',
      sex: 'female',
      status: 'adoptable'
    )

    @review1 = @shelter1.reviews.create(
      title: "A glowing review",
      rating: "5",
      content: "Great facility, friendly staff!",
      image: "https://i.imgur.com/dciDr8Q.jpg"
    )
  end

  it 'it links to a form to update the review' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content('A glowing review')
    expect(page).to have_content('Rating: 5')
    expect(page).to have_content('Great facility, friendly staff!')
    expect(page).to have_css("img[src*='#{@review1.image}']")

    click_link 'Edit Review'

    expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit")
  end

  it 'does not allow a user to update a review without required information' do
    visit "/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit"

    fill_in 'Title', with: 'Another glowing review'
    fill_in 'Image', with: 'https://i.imgur.com/dciDr8Q.jpg'
    fill_in 'Content', with: ''
    click_button 'Save'

    expect(page).to have_content('Review not updated. Please complete required fields.')
    expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/#{@review1.id}")
    expect(page).to have_button('Save')

    fill_in 'Title', with: 'Another glowing review'
    select '4', from: :rating
    fill_in 'Content', with: 'Super dope'
    fill_in 'Image', with: 'https://i.imgur.com/dciDr8Q.jpg'
    click_button 'Save'

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content('Another glowing review')
    expect(page).to have_content('Rating: 4')
    expect(page).to have_content('Super dope')
    expect(page).to have_css("img[src*='#{@review1.image}']")
  end
end
