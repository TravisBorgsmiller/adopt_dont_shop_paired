require 'rails_helper'

RSpec.describe 'When I visit a application show page', type: :feature do
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

    visit "/pets/#{@pet1.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet2.id}"
    click_button 'Favorite'

    visit '/favorites'
    click_link 'Adopt Pet(s)'

    expect(current_path).to eq('/applications/new')

    within("div#pet_#{@pet1.id}") do
      check :adopt_pets_
    end

    within("div#pet_#{@pet2.id}") do
      check :adopt_pets_
    end

    fill_in 'Name', with: 'Jordan'
    fill_in 'Address', with: '4231 Ponderosa Court'
    fill_in 'City', with: 'Boulder'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80301'
    fill_in 'Phone', with: '323.940.3227'
    fill_in 'Description', with: "I'm a puppy parent"
    click_button 'Submit'

    @application = Application.last
  end

  describe 'For every pet included on the application' do
    it 'I can click a link to approve the application for that pet' do
      visit "/applications/#{@application.id}"

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content(@application.name.to_s)
      expect(page).to have_content(@application.address.to_s)
      expect(page).to have_content(@application.city.to_s)
      expect(page).to have_content(@application.state.to_s)
      expect(page).to have_content(@application.phone.to_s)
      expect(page).to have_content(@application.description.to_s)
      expect(page).to have_link(@pet1.name)
      expect(page).to have_link("Approve Application for #{@pet1.name}")
    end
  end
end

# User Story 22, Approving an Application

# As a visitor
# When I visit an application's show page
# For every pet that the application is for, I see a link to approve the application 
# for that specific pet
# When I click on a link to approve the application for one particular pet
# I'm taken back to that pet's show page
# And I see that the pets status has changed to 'pending'
# And I see text on the page that says who this pet is on hold for (Ex: "On hold for 
# John Smith", given John Smith is the name on the application that was just accepted)