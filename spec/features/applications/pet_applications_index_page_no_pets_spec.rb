require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
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

    @pet2 = @shelter1.pets.create(
      image: 'https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg',
      name: 'Odell',
      description: 'good dog',
      age: '4',
      sex: 'male',
      status: 'adoptable'
    )

    @review1 = @shelter1.reviews.create(
      title: 'A glowing review',
      rating: '5',
      content: 'Great facility, friendly staff!',
      image: 'https://i.imgur.com/dciDr8Q.jpg'
    )
  end

  describe 'When I visit a pet applications index page with no applications' do
    it 'it displays a message' do
      visit "/pets/#{@pet1.id}/applications"

      expect(current_path).to eq("/pets/#{@pet1.id}/applications")

      within("div#noPetApplications") do
        expect(page).to have_content("No Applications for this Pet")
      end

      within("div.petsApplicationsIndexBlock") do
        expect(page).to_not have_content('Jordan Williams')
      end
    end
  end
end
