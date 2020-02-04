require 'rails_helper'

RSpec.describe "favorites index page", type: :feature do
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
    @pet2 = @shelter1.pets.create!(
      image: 'https://image.shutterstock.com/image-photo/brindled-plott-hound-puppy-on-600w-79691980.jpg',
      name: 'Xylia',
      age: '5',
      sex: 'female',
      description: 'cool cool',
      status: 'adoptable')
    end

    it "favoriting a pet displays it in the favorites index page" do
      visit "/pets/#{@pet1.id}"
      find_button("Favorite").click
      expect(page).to have_current_path("/pets/#{@pet1.id}")
      visit "/pets/#{@pet2.id}"
      find_button("Favorite").click
      expect(page).to have_current_path("/pets/#{@pet2.id}")
      click_link("Favorites: 2")
      expect(page).to have_current_path("/favorites")

      within "#favorites-#{@pet1.id}" do
        expect(page).to have_content(@pet1.name)
        expect(page).to have_css("img[src*='#{@pet1.image}']")
      end

      within "#favorites-#{@pet2.id}" do
        expect(page).to have_content(@pet2.name)
        expect(page).to have_css("img[src*='#{@pet2.image}']")
      end
    end
  end
