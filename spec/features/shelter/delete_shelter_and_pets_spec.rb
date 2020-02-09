require 'rails_helper'

RSpec.describe 'Shelters with no pending pets', type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "Mike's Shelter",
      address: '1331 17th Street',
      city: 'Denver',
      state: 'CO',
      zip: '80202'
    )

    @shelter2 = Shelter.create(
      name: "Meg's Shelter",
      address: '150 Main Street',
      city: 'Hershey',
      state: 'PA',
      zip: '17033'
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

    @pet3 = @shelter2.pets.create(
      image: 'https://s.abcnews.com/images/Lifestyle/puppy-ht-3-er-170907_16x9_992.jpg',
      name: 'Xylia',
      description: 'guardian',
      age: '5',
      sex: 'female',
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

    visit "/applications/#{@application.id}"
    click_link "Approve Application for #{@pet1.name}"
    visit "/applications/#{@application.id}"
    click_link "Approve Application for #{@pet2.name}"
  end

  describe 'can be removed' do
    it 'and will remove all pets' do
      visit '/shelters'

      expect(current_path).to eq('/shelters')
      expect(@shelter2.pets.first.name).to eq('Xylia')

      within("p#delete_#{@shelter2.id}") do
        click_link 'Delete'
      end

      expect(current_path).to eq('/shelters')
      expect(page).to have_content('Shelter Removed.')
      expect(page).to_not have_content(@shelter2.name)
    end
  end
end
