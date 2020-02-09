require 'rails_helper'

RSpec.describe 'When I delete a Shelter', type: :feature do
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

    @review1 = @shelter1.reviews.create(
      title: "A glowing review",
      rating: "5",
      content: "Great facility, friendly staff!",
      image: "https://i.imgur.com/dciDr8Q.jpg"
    )

    @review2 = @shelter2.reviews.create(
      title: "A stellar review",
      rating: "5",
      content: "They throw a frisbee with my dog",
      image: "https://i.imgur.com/dciDr8Q.jpg"
    )
  end

  it 'it deletes the reviews for that shelter' do
    visit '/shelters'

    within("p#delete_#{@shelter2.id}") do
      expect { click_link 'Delete' }.to change(Shelter && Review, :count).by(-1)
    end

    expect(page).to have_content("Shelter Removed.")
    expect(current_path).to eq('/shelters')

    within("p#delete_#{@shelter1.id}") do
      expect { click_link 'Delete' }.to change(Shelter && Review, :count).by(-1)
    end

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter Removed.")
    expect(page).to_not have_content("Meg's Shelter")
    expect(page).to_not have_content("Mike's Shelter")
  end
end
