require 'rails_helper'

RSpec.describe 'As a visitor when I delete a pet' do
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
    visit "/pets/#{@pet1.id}"
    click_button 'Favorite'
  end
  it 'deletes pet from favorites' do
    visit "/pets/#{@pet1.id}"
    within("p#delete_#{@pet1.id}") do
      expect { click_link 'Delete Pet' }.to change(Pet, :count).by(-1)
    end
    visit '/favorites'
    expect(page).to_not have_content(@pet1.name)
    visit '/pets'
    expect(page).to_not have_content(@pet1.name)
  end
end
