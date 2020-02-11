require 'rails_helper'

RSpec.describe 'When I visit a shelter show page', type: :feature do
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

    @review2 = @shelter1.reviews.create(
      title: 'A decent review',
      rating: '3',
      content: 'Hella decent all around.',
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

    fill_in :name, with: 'Jordan Williams'
    fill_in :address, with: '4231 Ponderosa Court'
    fill_in :city, with: 'Boulder'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80301'
    fill_in :phone, with: '323.940.3227'
    fill_in :description, with: "I'm a puppy parent"
    click_button 'Submit'

    expect(page).to have_content('Application submitted, thank you!')

    @application = Application.last
  end

  describe 'the shelter statistics are listed:' do
    it 'count of pets at shelter' do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content(@shelter1.pet_count.to_s)
      expect(page).to have_content(@shelter1.average_rating)
      expect(page).to have_content(@shelter1.pet_applications)
    end
  end
end
