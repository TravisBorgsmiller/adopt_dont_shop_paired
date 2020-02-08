require 'rails_helper'

RSpec.describe 'As a visitor when I visit application show page' do
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
      @app = Application.create(
        name: 'Joe',
        address: '302 woo hoo st',
        city: 'Nowhere',
        state: 'MO',
        zip: '63386',
        phone: '636-981-0204',
        description: 'Happy go lucky guy'
      )
      @app.pets << [@pet1, @pet2]

      visit "/pets/#{@pet1.id}"
      click_button 'Favorite'

      visit "/pets/#{@pet2.id}"
      click_button 'Favorite'
  end
  it 'allows to approve more than one pet' do
    visit "/applications/#{@app.id}"
    click_link "Approve Application for #{@pet1.name}"
    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Holding for: Joe")
    visit "/applications/#{@app.id}"
    click_link "Approve Application for #{@pet2.name}"
    visit "/pets/#{@pet2.id}"
    expect(page).to have_content("Holding for: Joe")
  end
end
