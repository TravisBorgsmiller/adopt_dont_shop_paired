require 'rails_helper'

RSpec.describe 'Shelters with pets', type: :feature do
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

    fill_in :name, with: 'Jordan'
    fill_in :address, with: '4231 Ponderosa Court'
    fill_in :city, with: 'Boulder'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80301'
    fill_in :phone, with: '323.940.3227'
    fill_in :description, with: "I'm a puppy parent"
    click_button 'Submit'

    @application = Application.last

    visit "/applications/#{@application.id}"
    click_link "Approve Application for #{@pet1.name}"
    visit "/applications/#{@application.id}"
    click_link "Approve Application for #{@pet2.name}"
  end

  describe "pending adoption can't be deleted" do
    it 'when I click delete' do
      visit '/shelters'

      within("p#delete_#{@shelter1.id}") do
        expect { click_link 'Delete' }.to change(Shelter && Pet, :count).by(0)
      end

      expect(page).to have_content('Pets Pending for Adoption. Resolve Before Deleting.')
    end
  end

  describe "not pending adoption can be deleted" do
    it 'when I click delete' do
      visit '/shelters'

      within("p#delete_#{@shelter2.id}") do
        expect { click_link 'Delete' }.to change(Shelter && Pet, :count).by(-1)
      end

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Shelter Removed.")
      expect(page).to_not have_content("Meg's Shelter")
    end
  end
end
