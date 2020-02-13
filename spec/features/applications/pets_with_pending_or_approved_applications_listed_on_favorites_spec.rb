require 'rails_helper'

RSpec.describe 'As a visitor when I visit the favorites index page' do
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
    @app1 = Application.create(
      name: 'Joe',
      address: '302 woo hoo st',
      city: 'Nowhere',
      state: 'MO',
      zip: '63386',
      phone: '636-981-0204',
      description: 'Happy go lucky guy'
    )
    @app1.pets << [@pet1, @pet2]

    @app2 = Application.create(
      name: 'Steve',
      address: '101 Yo yo ma',
      city: 'Somewhere',
      state: 'CO',
      zip: '80602',
      phone: '864-789-0908',
      description: 'Fun and spiritual'
    )
    @app2.pets << [@pet1, @pet2]
    visit "/applications/#{@app1.id}"
    click_link "Approve Application for #{@pet1.name}"
    @pet1.reload
    @app1.reload
  end

it 'shows pets with pending applications' do
  visit '/favorites'
    within('section#approved_adoption') do
      expect(page).to have_content(@pet1.name)
    end

    within("div#pet_#{@pet2.id}") do
      expect(page).to have_content(@pet2.name)
    end

  visit "/applications/#{@app1.id}"
  click_link "Unapprove Application for #{@pet1.name}"
  visit '/favorites'

    within("div#pet_#{@pet1.id}") do
      expect(page).to have_content(@pet1.name)
    end
  end
end
