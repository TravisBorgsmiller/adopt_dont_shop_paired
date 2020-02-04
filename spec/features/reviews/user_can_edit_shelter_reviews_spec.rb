require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a shelter show page and click edit review' do
    it 'it loads a form to update the review' do
      shelter1 = Shelter.create(
        name: "Mike's Shelter",
        address: '1331 17th Street',
        city: 'Denver',
        state: 'CO',
        zip: '80202'
      )

      pet1 = shelter1.pets.create(
        image: 'https://cdn2-www.dogtime.com/assets/uploads/2011/03/puppy-development.jpg',
        name: 'Athena',
        description: 'butthead',
        age: '1',
        sex: 'female',
        status: 'adoptable'
      )

      review1 = shelter1.reviews.create(
        title: "A glowing review",
        rating: "5",
        content: "Great facility, friendly staff!",
        image: "https://i.imgur.com/dciDr8Q.jpg"
      )

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_content('A glowing review')
      expect(page).to have_content('Rating: 5')
      expect(page).to have_content('Great facility, friendly staff!')
      expect(page).to have_css("img[src*='#{review1.image}']")
      click_link 'Update Review'

      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")

      fill_in 'Title', with: 'Another glowing review'
      fill_in 'Rating', with: '4'
      fill_in 'Content', with: 'Super dope'
      fill_in 'Image', with: 'https://i.imgur.com/dciDr8Q.jpg'
      click_button 'Save'

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to have_content('Another glowing review')
      expect(page).to have_content('Rating: 4')
      expect(page).to have_content('Super dope')
      expect(page).to have_css("img[src*='#{review1.image}']")
    end
  end
end

# User Story 5, Edit a Shelter Review

# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review