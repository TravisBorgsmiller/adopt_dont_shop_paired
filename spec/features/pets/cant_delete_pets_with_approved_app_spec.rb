require 'rails_helper'

RSpec.describe 'As a visitor when a pet has an approved app' do
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

    @app = Application.create(
      name: 'Joe',
      address: '302 woo hoo st',
      city: 'Nowhere',
      state: 'MO',
      zip: '63386',
      phone: '636-981-0204',
      description: 'Happy go lucky guy'
    )
    @app.pets << @pet1

    visit "/pets/#{@pet1.id}"
    click_button 'Favorite'
  end
  it 'wont allow you to delete pet' do
    visit "/pets/#{@pet1.id}"
    click_link 'Applications'
    click_link 'Joe'
    click_link "Approve Application for #{@pet1.name}"
    within("p#delete_#{@pet1.id}") do
      expect { click_link 'Delete Pet' }.to change(Pet, :count).by(0)
    end
    click_link 'Delete Pet'
    expect(page).to have_content("Pet can't be deleted, approved applications exist")
    expect(current_path).to eq("/pets/#{@pet1.id}")
  end
end
