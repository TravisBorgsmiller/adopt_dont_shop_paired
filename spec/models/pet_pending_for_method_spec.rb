require 'rails_helper'

RSpec.describe Pet, type: :model do
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
  end

  context 'pending_for', type: :feature do
    it 'will provide the name of the pending applicant for a pet' do
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
      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(@pet1.pending_for).to eq('Jordan')
    end
  end
end
