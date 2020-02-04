require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit shelters index page' do
    it "Then I see the name of each shelter" do
      shelter3 = Shelter.create!(name: 'Zeus\'s Puppy Pals',
                                address: '3734 Cedar Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      visit '/shelters'

      expect(page).to have_content(shelter3.name)
    end
  end
end
